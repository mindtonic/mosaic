module Lennon 
  class Image
  	include LennonReporting
		include Magick
		
		attr_accessor :location, :canvas, :maximum_width, :maximum_height, :average_color, :pixel_array
  
  	def initialize(location)
  		@location = location
  		@maximum_width = 400
  		@maximum_height = 400
  	end
  	
  	def canvas_factory
  		report "-- Downloading Image"
			@canvas ||= Magick::ImageList.new(@location)
  	end
  	
    def resize!
    	canvas_factory
    	if @canvas[0].rows > @maximum_width or @canvas[0].columns > @maximum_height
    		report "-- Resizing Image"
    		@canvas.change_geometry!("#{@maximum_width}x#{@maximum_height}") {|cols, rows, img| img.resize!(cols, rows)}
    	else
    		report "-- Image does not need to be resized"
    	end
    end
  
  	def calculate_average_color
  		resize!
  	
  		report "-- Calculating Average Color"
		  red, green, blue = 0, 0, 0
		  canvas.each_pixel { |pixel, c, r|
		    red += pixel.red
		    green += pixel.green
		    blue += pixel.blue
		  }
		  num_pixels = canvas.bounding_box.width * canvas.bounding_box.height
		  
		  @average_color = {
  			:red => red/num_pixels,
  			:green => green/num_pixels,
  			:blue => blue/num_pixels
  		}
  	end
  	
		def create_pixel_array
			resize!
			@pixel_array = []
			report "-- Collecting Image Pixels"
			@canvas.each_pixel do |pixel, c, r|  
			  @pixel_array << {:red => pixel.red, :green => pixel.green, :blue => pixel.blue}  
			end
		end	
 	end
end