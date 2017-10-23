class GroupController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, :only => [:create]
  def index
    @roles = Role.all
    @groups = Group.all
  end

  def new
    @roles = Role.all
    respond_to do |format|
      format.html{redirect_to '/dang_nhap'}
      format.js
    end
  end

  def create
    @group = Group.new(name: params[:name])
    @roles = Role.where(id: params[:role])
    @group.roles = @roles;
    if @group.save
      @groups = Group.all
      respond_to do |format|
        format.js
      end
    end

  end
end
