require 'zip'

class LessonController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params.merge(lesson_type_id: params[:type_id],
                                             course_id: params[:course_id], user_id: current_user.id))
    type = LessonType.find_by_id(params[:type_id])

    # If type doesn't exist
    # Return 500 cause wrong parameter
    render '500.html' unless type

    # Validate scorm
    if type.name == 'Scorm'
      unless valid_zip?(@lesson.file.file.path)
        flash[:danger] = 'Bài giảng không hợp lệ'
        path_to_lesson = @lesson.file.file.path
        File.delete(path_to_lesson) if File.exist?(path_to_lesson)
        return
      end
      Zip::File.open(@lesson.file.file.path) do |zipfile|
        zipfile.each do |file|
          f_path = File.join("public/bai-hoc/#{@lesson.id}/" + file.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zipfile.extract(file, f_path) unless File.exist?(f_path)
        end
      end

      if File.exist?("public/bai-hoc/#{@lesson.id}/index.htm")
        File.rename("public/bai-hoc/#{@lesson.id}/index.htm", "public/bai-hoc/#{@lesson.id}/index.html")
      end
      unless File.exist?("public/bai-hoc/#{@lesson.id}/index.html")
        File.delete(@lesson.file.file.path) if File.exist?(@lesson.file.file.path)
        flash[:danger] = 'Bài giảng không hợp lệ'
        return
      end
      @lesson.url = '/bai-hoc/' + @lesson.id.to_s + '/index.html'

      redirect_to course_detail_path(id: params[:course_id]) if @lesson.save
    end

    # Validate Web
    if type.name == 'Web'

    end

    # Validate Video
    if type.name == 'Video'
		accepted_formats = [".mp4", ".webm"]
		unless accepted_formats.include? File.extname("example.pdf")
			flash[:danger] = 'Bài giảng không hợp lệ'
			redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id])
		end
    end

    # Validate Âm thanh
    if type.name == 'Âm thanh'

    end

    # Validate Hình ảnh
    if type.name == 'Hình ảnh'

    end

    # Validate Flash
    if type.name == 'Flash'

    end

    # Validate Bài kiểm tra
    if type.name == 'Bài kiểm tra'

    end
  end

  def edit; end

  def update; end

  def show
    @lesson = Lesson.find_by_id(params[:id])
    commontator_thread_show(@lesson)
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :file)
  end

  def valid_zip?(file)
    zip = Zip::File.open(file)
    true
  rescue Zip::Error
    false
  ensure
    zip.close if zip
  end
end
