class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  def create
		user = User.authenticate(params[:session][:email], params[:session][:password])

		# if user.nil?
		# 	flash.now[:error]	= "Invalid email/password combination."
		# 	# respond_to do |format|
		# 	# 	format.json{variable data json: "Invalid email/password Combination"}
		# 	# end
		# else
		# 	sign_in user
		# 	respond_to do |format|
		# 		format.json{variable data json: "/users/#{user.id}"}
		# 	end
		# 	#redirect_to "/users/#{user.id}"
		# end

		respond_to do |format|
	      if !user.nil?
	      	sign_in user
	        format.html { redirect_to "/users/#{user.id}"}
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
