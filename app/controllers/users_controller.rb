class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        if params[:video_id]
          format.json { render json: { url: "/v/#{params[:video_id]}"} }
        else
          #format.html { redirect_to "/users/#{user.id}"}
          format.json { render json: { url: "/users/#{current_user.id}"} }
        end
      else

        @errors = ""

        @user.errors.each do |key, values|  
          value_content = values
          if values.kind_of?(Array)
            value_content += "#{values[0]}"
          end
          key = key.to_s.split("_").map(&:capitalize).join(" ")
          @errors += "#{key} #{value_content}<br/>"
        end

        format.html { render action: "new" }
        format.json { render json: { error: @errors } }
      end
    end

  end


  def show
  	@user = User.find(current_user.id)
    @videos = @user.videos
  end
end
