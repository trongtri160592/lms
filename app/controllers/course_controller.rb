class CourseController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @course = Course.new
  end

  def new

  end

  def create

  end

  def edit
    @user = User.find(params[:id])
  end

  def update

  end
end
