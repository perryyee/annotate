class VideosController < ApplicationController
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

  def new
  	@user = User.new
  end

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

  def video
  	@user = User.new
  	@video = Video.find(params[:id])
    @notes = @video.notes.order("time asc")

    @note = @video.notes.new
  end
end
