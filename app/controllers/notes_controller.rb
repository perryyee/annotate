class NotesController < ApplicationController
  def index
  end

  def new
  end

  def create
  	@video = Video.find(params[:video_id])
  	
  	# if @video.notes.create(params[:note])
   #    redirect_to "/videos/#{params['note']['video_url']}"
   #  else
   #    render action: "new"
   #  end
   @note = @video.notes.create(params[:note])
   @note.video_id = params[:video_id]

    respond_to do |format|
      if @note.save
      	format.html { redirect_to "/videos/#{@video.url}" }
        format.json { render json: @note, status: :created }
      else
      	format.html { render action: "new" }
        format.json { variable render json: @note.errors, status: :unprocessable_entity }
      end
    end

  end

end
