class Video < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :notes
  belongs_to :user
  
end
