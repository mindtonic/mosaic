module Lennon
	class Source
	
		attr_accessor :address, :source_code, :images
		
		def initialize(address)
			@address = address
			@images = Array.new
		end
		
		def open_sesame
			@source_code ||= open(@address)
		end
	
	  def pull_images
	  	open_sesame
    	(Hpricot::XML(@source_code)/"enclosure").each {|z| @images << Lennon::Image.new(z.attributes['url'])}
    end
	
	end
end