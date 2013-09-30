class StaticController < ApplicationController
  def index
  	@user = User.new
  end
end
