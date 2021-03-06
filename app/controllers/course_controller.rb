class CourseController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
    @users = User.all
    @course = Course.new
  end

  def new

  end

  def create
    course = Course.new(course_params)
    if course.save

    else
      @error = true
    end
    @courses = Course.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

  end

  def detail
    @course = Course.find_by_id(params[:id])
    @lessons = @course.lessons
  end

  private
  def course_params
    params.require(:course).permit(:name, :topic, :introduction, :head_teacher_id, teacher_ids: [])
  end
end
