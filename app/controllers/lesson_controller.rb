require 'zip'

class LessonController < ApplicationController
  before_action :authenticate_user!

  def index;
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params.merge(lesson_type_id: params[:type_id],
                                             course_id: params[:course_id], user_id: current_user.id))
    type = LessonType.find_by_id(params[:type_id])

    if @lesson.errors.any?
      render 'new' and return
    end

    @lesson.save

    # If type doesn't exist
    # Return 500 cause wrong parameter
    render '500.html' and return unless type

	path_to_lesson = @lesson.file.file.path
    # Validate scorm
    if type.name == 'Scorm'
      unless valid_zip?(path_to_lesson)
        flash[:danger] = 'Bài giảng không hợp lệ'
        File.delete(path_to_lesson) if File.exist?(path_to_lesson)
        @lesson.destroy
        render 'new' and return
      end
      Zip::File.open(path_to_lesson) do |zipfile|
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
        File.delete(path_to_lesson) if File.exist?(path_to_lesson)
        flash[:danger] = 'Bài giảng không hợp lệ'
        @lesson.destroy
        return
      end
	  # Success
      @lesson.url = '/bai-hoc/' + @lesson.id.to_s + '/index.html'
      @lesson.save
      redirect_to course_detail_path(id: params[:course_id]) and return
    end

    # Validate Web
    if type.name == 'Web'
	  accepted_formats = [".htm", ".html"]
      unless accepted_formats.include? File.extname(path_to_lesson)
        flash[:danger] = 'Web không hợp lệ'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
      unless @lesson.save
        flash[:danger] = 'Không thể lưu được web'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
	  # Success
	  @lesson.url = path_to_lesson
	  @lesson.save
      redirect_to course_detail_path(id: params[:course_id]) and return
    end

    # Validate Video
    if type.name == 'Video'
      accepted_formats = [".mp4", ".webm"]
      unless accepted_formats.include? File.extname(path_to_lesson)
        flash[:danger] = 'Video không hợp lệ'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
      unless @lesson.save
        flash[:danger] = 'Không thể lưu được video'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
	  # Success
	  @lesson.url = path_to_lesson
	  @lesson.save
      redirect_to course_detail_path(id: params[:course_id]) and return
    end

    # Validate Âm thanh
    if type.name == 'Âm thanh'
      accepted_formats = [".mp3"]
      unless accepted_formats.include? File.extname(path_to_lesson)
        flash[:danger] = 'Audio không hợp lệ'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
      unless @lesson.save
        flash[:danger] = 'Không thể lưu được audio'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
	  # Success
	  @lesson.url = path_to_lesson
	  @lesson.save
      redirect_to course_detail_path(id: params[:course_id]) and return	  
    end

    # Validate Hình ảnh
    if type.name == 'Hình ảnh'
      accepted_formats = ["jpg", "jpeg", "gif", "png"]
      unless accepted_formats.include? File.extname(path_to_lesson)
        flash[:danger] = 'Hình ảnh không hợp lệ'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
      unless @lesson.save
        flash[:danger] = 'Không thể lưu được hình ảnh'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
	  # Success
	  @lesson.url = path_to_lesson
	  @lesson.save	  
      redirect_to course_detail_path(id: params[:course_id]) and return	  
    end

    # Validate Flash
    if type.name == 'Flash'
      accepted_formats = ["swf"]
      unless accepted_formats.include? File.extname(path_to_lesson)
        flash[:danger] = 'Flash không hợp lệ'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
      unless @lesson.save
        flash[:danger] = 'Không thể lưu được flash'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
	  # Success
	  @lesson.url = path_to_lesson
	  @lesson.save	  
      redirect_to course_detail_path(id: params[:course_id]) and return	  
    end

    # Validate Bài kiểm tra
    if type.name == 'Bài kiểm tra'
	  
    end

    # Validate Tài liệu
    if type.name == 'Tài liệu'
      accepted_formats = [".doc", ".docx", ".ppt", ".pptx"]
      unless accepted_formats.include? File.extname(path_to_lesson)
        flash[:danger] = 'Bài giảng không hợp lệ'
        @lesson.destroy
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
      Dir.mkdir("public/bai-hoc/#{@lesson.id}")
      Libreconv.convert(path_to_lesson, "public/bai-hoc/#{@lesson.id}/index.html", nil, 'html')
      unless File.exist?("public/bai-hoc/#{@lesson.id}/index.html")
        File.delete(@lesson.file.file.path) if File.exist?(path_to_lesson)
        flash[:danger] = 'Bài giảng không hợp lệ'
        @lesson.destroy
        render 'new'
        return
      end
      @lesson.url = '/bai-hoc/' + @lesson.id.to_s + '/index.html'
      if @lesson.save
		# Success
        redirect_to course_detail_path(id: params[:course_id]) and return
      else
        flash[:danger] = 'Không thể luu bài giảng'
        redirect_to lesson_new_path(type_id: params[:type_id], course_id: params[:course_id]) and return
      end
    end
  end

  def edit;
  end

  def update;
  end

  def show
    @lesson = Lesson.find(params[:id])
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
