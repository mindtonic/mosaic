module Lennon
	class Source
  	include LennonReporting
	
		attr_accessor :address, :source_code, :images
		
		def initialize(address)
			@address = address
			@images = Array.new
		end
		
		def open_sesame
      report "-- Opening Source"
			@source_code ||= open(@address)
			report "-- Source Opened"
		end
	
	  def pull_images
	  	open_sesame
	  	report "-- Downloading Source Images"
    	(Hpricot::XML(@source_code)/"enclosure").each do |z|
    		@images << Lennon::Image.new(z.attributes['url'])
    	end
    	report "-- Source Images Downloaded"
    end	
	end
end