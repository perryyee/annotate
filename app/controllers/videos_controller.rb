class VideosController < ApplicationController
  def index
  	@user = User.new
  	if params[:search]
  		query = params[:search].split(" ").join("+")
  	end
  	
  	@data = youtube_get(query)

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
  	video.url = "www.youtube.com/watch?v=#{@video_url}"
  	video.save

  	@video = Video.find(video.id)
  	@note = @video.notes.new
  end
end
