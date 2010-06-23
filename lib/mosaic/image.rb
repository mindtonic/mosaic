module Mosaic 
  class Image
		include Magick
		
		attr_accessor :location, :magick, :maximum_width, :maximum_height
  
  	def initialize(location)
  		@location = location
  		@maximum_width = 1000
  		@maximum_height = 1000
  	end
  	
  	def magick_factory
			@magick ||= Magick::ImageList.new(@location)  	
  	end
  	
    def resize!
    	magick_factory
    	@magick.change_geometry!("#{@maximum_width}x#{@maximum_height}") {|cols, rows, img| img.resize!(cols, rows)}
    end
  
 	end
end