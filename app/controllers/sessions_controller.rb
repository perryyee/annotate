class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new
		user = User.authenticate(params[:session][:email], params[:session][:password])

		respond_to do |format|
	    if !user.nil?
	    	sign_in user
	    	if params[:video_id]
	    		format.json { render json: { url: "/v/#{params[:video_id]}"} }
	    	else
	      	format.json { render json: { url: "/users/#{user.id}"} }
	      end
	    else
	      format.html { render action: "new" }
	      format.json { render json: { error: "Invalid email/password Combination" } }
	    end
    end
	end

	def destroy
		sign_out
		redirect_to "/"
	end
end
