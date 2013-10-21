class StaticController < ApplicationController
  #Landing Page
  def index
  	@user = User.new
  end
end
