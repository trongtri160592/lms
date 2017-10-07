class UserController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:add_user]
  require 'rubygems'
  require 'roo'

  def index
    @users = User.all
  end

  def add_user
    uploader = UserUploader.new
    uploader.store!(params[:file])

    list = Roo::Spreadsheet.open "#{Rails.public_path}/#{uploader.store_path}"
    sheet = list.sheet(0)
    sheet.each() do |row|
      p = User.new
      p.username = row[0]
      p.email = row[1]
      p.password = row[2]
      p.save
    end
    uploader.remove!
    respond_to do |format|
      format.js
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      @edit_result = "success"
    else
      Rails.logger.info(@user.errors.messages.inspect)
      @edit_result = @user.errors
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :username, :first_name, :last_name, :sex, :active, :date_of_birth, :phone, :address, :workplace,
                                 :academic_degree, :public_info, :biography, :group_id)
  end
end
