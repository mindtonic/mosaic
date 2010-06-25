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
		end
	
	  def pull_images
	  	open_sesame
	  	report "-- Downloading Source Images"
    	(Hpricot::XML(@source_code)/"enclosure").each do |z|
    		@images << Lennon::Image.new(z.attributes['url'])
    	end
    end
	end
end