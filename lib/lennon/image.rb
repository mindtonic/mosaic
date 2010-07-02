module Lennon 
  class Image
  	include LennonReporting
		include Magick
		
		attr_accessor :location, :canvas, :maximum_width, :maximum_height, :average_color, :pixel_array, :hsl
  
  	def initialize(location)
  		@location = location
  		@maximum_width = 40
  		@maximum_height = 40  		
  		canvas_factory
  		resize!
  		calculate_average_color
  		calculate_hsl
  	end
  	
  	def canvas_factory
  		report "-- Downloading Image"
  		begin	
    		@canvas ||= Magick::ImageList.new(@location)
    	rescue Magick::ImageMagickError
    		@source.images.delete(image)
    	end
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
  
  	def calculate_average_color
  		#resize!
  	
  		report "-- Calculating Average Color"
		  red, green, blue = 0, 0, 0
		  @canvas.each_pixel { |pixel, c, r|
		    red += pixel.red
		    green += pixel.green
		    blue += pixel.blue
		  }
		  num_pixels = @canvas.bounding_box.width * @canvas.bounding_box.height
		  
		  @average_color = {
  			:red => red/num_pixels,
  			:green => green/num_pixels,
  			:blue => blue/num_pixels
  		}
  	end
  	
  	def calculate_hsl
  		#resize!
  	
  		report "-- Calculating HSL Value"
		  hue, saturation, lightness, alpha = 0, 0, 0, 0
		  @canvas.each_pixel { |pixel, c, r|
		  	h, s, l, a = pixel.to_hsla
		    hue += h
		    saturation += s
		    lightness += l
		    alpha += a
		  }
		  num_pixels = @canvas.bounding_box.width * @canvas.bounding_box.height
		  
		  @hsl = {
  			:hue => hue/num_pixels,
  			:saturation => saturation/num_pixels,
  			:lightness => lightness/num_pixels,
  			:alpha => alpha/num_pixels
  		}
  	end
 	end
end