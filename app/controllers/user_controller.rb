class UserController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, :only => [:add_list]
  require 'rubygems'
  require 'roo'

  def index
    @users = User.all
  end

  def add_list
    uploader = UserUploader.new
    uploader.store!(params[:file])

    list = Roo::Spreadsheet.open "#{Rails.public_path}/#{uploader.store_path}"
    sheet = list.sheet(0)
    sheet.each() do |row|
      p = User.new
      p.username = row[0]
      p.email = row[1]
      p.password = row[2]
      if p.save
        logger.debug "Luu nguoi dung thanh cong"
      else
        logger.debug "Loi: #{p.errors.messages}"
      end
    end
    uploader.remove!
    respond_to do |format|
      format.js
    end
    @users = User.all
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
