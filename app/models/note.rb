class Note < ActiveRecord::Base
  attr_accessible :content, :time, :title, :url
  belongs_to :video

  validates :title,    :presence => true,
            :length              => { :minimum => 1 }
  validates :time,     :presence => true

end
