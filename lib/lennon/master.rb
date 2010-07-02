module Lennon 
  class Master
  	include LennonReporting
		include Magick
		
		attr_accessor :location, :canvas, :maximum_width, :maximum_height, :pixel_array, :hsl_pixel_array
  
  	def initialize(location)
  		@location = location
  		@maximum_width = 100
  		@maximum_height = 100
  		canvas_factory
  		resize!
  		create_pixel_array
  	end
  	
  	def canvas_factory
  		report "-- Downloading Image"
			@canvas ||= Magick::ImageList.new(@location)
  	end
  	
    def resize!
    	#canvas_factory
    	if @canvas[0].rows > @maximum_width or @canvas[0].columns > @maximum_height
    		report "-- Resizing Image"
    		@canvas.change_geometry!("#{@maximum_width}x#{@maximum_height}") {|cols, rows, img| img.resize!(cols, rows)}
    	else
    		report "-- Image does not need to be resized"
    	end
    end
  	
		def create_pixel_array
			#resize!
			@pixel_array = []
			report "-- Collecting Image Pixels"
			@canvas.each_pixel do |pixel, c, r|  
			  @pixel_array << {:red => pixel.red, :green => pixel.green, :blue => pixel.blue}  
			end
		end
		
		def create_hsl_pixel_array
			@hsl_pixel_array = []
			report "-- Collecting Image Pixels"
			@canvas.each_pixel do |pixel, c, r|
				hue, saturation, lightness, alpha = pixel.to_hsla
			  @hsl_pixel_array << {:hue => hue, :saturation => saturation, :lightness => lightness, :alpha => alpha}  
			end
		end	
 	end
end