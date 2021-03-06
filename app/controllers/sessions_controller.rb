class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  #Handles the creation of a session upon user login
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

	#Handles the user logout by destrogin the session
	def destroy
		sign_out
		redirect_to "/"
	end
end
