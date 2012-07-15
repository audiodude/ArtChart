require 'csv'    

namespace :wga_data do
  desc "Import data from the WGA CSV file"
  task :import => :environment do
    csv_text = File.new(File.join(Rails.root, 'db', 'wga_catalog.csv')).read()
    csv = CSV.parse(csv_text, :headers => true)
    n = 0
    csv.each do |row|
      row = row.to_hash

      artist = nil
      if !row["AUTHOR"].blank?
        artist_name = row["AUTHOR"]
        if artist_name =~ /(.*), (.*)(, .*)?/
          if $3
            artist_name = $2 + ' ' + $1.titleize + $3
          else
            artist_name = $2 + ' ' + $1.titleize
          end
        else
          artist_name = artist_name.titleize
        end
        artist_name.gsub(/D'\w/) do |match|
          p = match.split("'")
          p[0] + "'" + p[1].upcase
        end

        artist = Artist.find_or_initialize_by_name(artist_name)
      end

      location = nil
      if !row["LOCATION"].blank?
        location = Location.find_or_initialize_by_name(row["LOCATION"])
      end

      if !location.blank? && !artist.blank?
        work = Work.create!(:name => row["TITLE"], :location => location, :artist => artist, :url => row["URL"])
      end

      n += 1
      if n%1000 == 0
        puts "Finished next 1000 rows, total: #{n}"
      end
   end
 end
end
