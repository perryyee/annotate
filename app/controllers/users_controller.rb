class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      if params[:video_id]
        redirect_to "/v/#{params[:video_id]}"
      else
  		  redirect_to "/users/#{current_user.id}"
      end
  	else
  		render action: 'new'
  	end
  end

  def show
  	@user = User.new
  end
end
