module ApplicationHelper
	include SessionsHelper
	
	require 'net/https'
	require 'json'

	def youtube_get(query)
		url = URI.parse("https://www.googleapis.com/youtube/v3/search?q=#{query}&type=video&part=snippet&maxResults=10&key=AIzaSyDdqP44d0C4l29FsjlIdtfNf7aGZrYnN9c")

		response = Net::HTTP.start(url.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
		  http.get url.request_uri, 'User-Agent' => 'MyLib v1.2'
		end

		case response
		when Net::HTTPRedirection
		  # repeat the request using response['Location']
		when Net::HTTPSuccess
		  repo_info = JSON.parse response.body
		else
		  # response code isn't a 200; raise an exception
		  response.error!
		end
	end

	def get_video(video_id)
		url = URI.parse("https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&part=snippet&maxResults=10&key=AIzaSyDdqP44d0C4l29FsjlIdtfNf7aGZrYnN9c")

		response = Net::HTTP.start(url.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
		  http.get url.request_uri, 'User-Agent' => 'MyLib v1.2'
		end

		case response
		when Net::HTTPRedirection
		  # repeat the request using response['Location']
		when Net::HTTPSuccess
		  repo_info = JSON.parse response.body
		else
		  # response code isn't a 200; raise an exception
		  response.error!
		end
	end
end
