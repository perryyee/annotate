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
	      		format.json { render json: "/v/#{params[:video_id]}"} 
	      	else
	        	#format.html { redirect_to "/users/#{user.id}"}
	        	format.json { render json: "/users/#{user.id}"} 
	        end
	      else
	        format.html { render action: "new" }
	        format.json { variable render json: "Invalid email/password Combination", status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
		sign_out
		redirect_to "/"
	end
end
