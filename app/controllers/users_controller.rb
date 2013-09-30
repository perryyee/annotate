class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to "/"
  	else
  		render action: 'new'
  	end
  end

  def show
  	@user = User.new
  end
end
