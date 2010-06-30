module Lennon
  class Mosaic
  	include LennonReporting
		include Magick
		
  	attr_accessor :master, :source, :feedback, :canvas, :average_colors, :mosaic_images
  
    def initialize(master, source, output = false)
      @master = Lennon::Master.new(master)
      @source = Lennon::Source.new(source)
      @feedback = Lennon::Feedback.instance
      @feedback.puts "Welcome to the Lennon Mosaic!"
      @feedback.print_to_console! if output
    end

		#
		# Manager
		#
    
    def imagine!
    	report "....... Imagining A Mosaic! ......."
			create_mosaic
			save
			report "....... All Done! ......."
			report lyrics
    end

		#
		# Prep
		#
    
    def prepare_the_master
    	@master.create_pixel_array
    end
    
    def collect_the_source_images
    	@source.pull_images
    end
    
    def prepare_the_source_images
    	collect_the_source_images
    	num = 1
    	@source.images.each do |image|
    		begin	
	    		report "Processing Image #{num} of #{@source.images.length}" 
	    		image.calculate_average_color
	    		image.calculate_hsl
	    		num += 1
	    	rescue Magick::ImageMagickError
	    		@source.images.delete(image)
	    	end
    	end
    end

		#
		# Create
		#

		def create_mosaic
			report "-- Building Mosaic"
			
			prepare_the_master
			prepare_the_source_images
			
			tile_size = 40
			@mosaic_images = ImageList.new
			tile = Rectangle.new(tile_size,tile_size,0,0)
			num = 0
			@master.canvas.bounding_box.height.times do |row|
			  @master.canvas.bounding_box.width.times do |col|
			  	report "-- Examining Pixel #{num + 1} of #{@master.pixel_array.length}"
			    @mosaic_images << find_best_image(@master.pixel_array[num]).canvas.crop_resized(tile_size,tile_size)
			    tile.x = col * @mosaic_images.columns
			    tile.y = row * @mosaic_images.rows
			    @mosaic_images.page = tile    
			    num = num.next
			  end
			end
			
			report "-- Mosaic Built"
		end
		
		def find_best_image(master_pixel)
			differences = []
			@source.images.collect {|image| differences << color_difference(master_pixel, image.average_color) }
			@source.images[differences.index(differences.min)]
		end
	
		def color_difference(rgb1, rgb2)
		  red, green, blue = rgb1[:red] - rgb2[:red], rgb1[:green] - rgb2[:green], rgb1[:blue] - rgb2[:blue]
		  Math.sqrt((red * red) + (green * green) + (blue * blue))
		end
		
		#
		# Save
		#
		
		def save
			report "-- Saving Mosaic"
			mosaic = @mosaic_images.mosaic
			mosaic.write('mosaic.jpg')
		end
  end
end

