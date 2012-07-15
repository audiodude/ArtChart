class Work < ActiveRecord::Base
  attr_accessible :name, :location, :artist, :url
  belongs_to :artist
  belongs_to :location
end
