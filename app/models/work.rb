class Work < ActiveRecord::Base
  attr_accessible :name, :location, :artist, :url
  belongs_to :artist
  belongs_to :location

  define_index do
    indexes name
    indexes location.name, :as => :location
    indexes artist.name, :as => :artist
  end

end
