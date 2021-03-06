class VideosController < ApplicationController
  
  #Handles Youtube Video search function, formats query properly, and handles pageTokens
  def index
  	@user = User.new
  	if params[:search]
  		query = params[:search].split(" ").join("+")
  	end

    @search = params[:search]
    puts params[:search]

  	if params[:nextPage] 
      @data = youtube_get(query, params[:nextPage])
    elsif params[:prevPage]
      @data = youtube_get(query, params[:prevPage])
    else
  	  @data = youtube_get(query)
    end

  end

  #Creates a new video, and displays video information
  def show
  	@user = User.new
  	@video_url = params[:id]

  	@title = get_video(params[:id])['items'][0]['snippet']['title']

  	video = Video.new
  	video.name = @title
  	video.url = @video_url
  	video.save

  	@video = Video.find(video.id)
  	@note = @video.notes.new
  end

  #Video display for saved video
  def video
  	@user = User.new
  	@video = Video.find(params[:id])
    @notes = @video.notes.order("time asc")

    @note = @video.notes.new
  end

  #Handles user adding video to favorites, creates a new video with notes for and adds ownership to user
  def favorite
    @video = Video.find(params[:id])
    @notes = @video.notes

    @new_video = Video.new
    
    @new_video.url = @video.url
    @new_video.name = @video.name
    @new_video.user_id = current_user.id
    
    respond_to do |format|
      if @new_video.save
        @notes.each do |note|
          @new_note = @new_video.notes.create(title: note.title, time: note.time, content: note.content)
        end
        format.json { render json: { result: "Success" } }
      else
        format.json { render json: { result: "Failed" } }
      end
    end

  end
end
