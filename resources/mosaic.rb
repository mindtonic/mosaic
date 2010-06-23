=begin

http://developer.yahoo.net/blog/archives/2008/09/photo_mosaics_with_yahoo_boss_image_search.html

Algorithm

	Master Photo
		Take a photo, called the master photo, and reduce it into a small and manageable size.
	
	Photo Sources
		Either as Images come in or as a process over a group of pre-selected images, create a database record of the image's URL
		Then for each photo tile, we get the average color of the tile and store it for later use	
	
	Photo Processing
		For each pixel in the reduced master photo, we compare its color with any of the photo tiles' average color and look for 
			the closest match
		We pick the closest match and use that photo tile in place of the pixel in a new image and repeat for each pixel in the 
			master photo

=end

class Mosaic
	attr_accessor :master, :pixel_array, :images

	# Resize Master Image
	def resize_master_image(master_image)
		width = 100
		@master = ImageList.new(master_image)
		@master.resize_to_fit!(width,(@master.bounding_box.height.to_f/@master.bounding_box.width.to_f)*width)
	end

	# Create Array of Pixels
	def create_pixel_array
		@pixel_array = []
		@master.each_pixel do |pixel, c, r|  
		  @pixel_array << {:red => pixel.red, :green => pixel.green, :blue => pixel.blue}  
		end
	end
	
	# The average color of each photo in the photo tiles ImageList
	def average_colors
		average_colors = []
		num = 1
		photo_tiles.each do |img|
			average_colors << average_color(img)
			num = num.next
		end
	end
	
	# Create the image Mosaic
	def create_mosaic
		tile_size = 40
		mosaic_images = ImageList.new
		tile = Rectangle.new(tile_size,tile_size,0,0)
		photo_tiles.scene = 0
		num = 0
		master.bounding_box.height.times do |row|
		  master.bounding_box.width.times do |col|
		    idx = match_photo(pixel_array[num], average_colors)
		    mosaic_images << photo_tiles[idx].crop_resized(tile_size,tile_size)
		    tile.x = col * mosaic_images.columns
		    tile.y = row * mosaic_images.rows
		    mosaic_images.page = tile
		    (photo_tiles.scene += 1) rescue photo_tiles.scene = 0    
		    num = num.next
		  end
		end	
	end
	
private

	# Find the average color of an image.
	def average_color(image)
	  red, green, blue = 0, 0, 0
	  image.each_pixel { |pixel, c, r|
	    red += pixel.red
	    green += pixel.green
	    blue += pixel.blue
	  }
	  num_pixels = image.bounding_box.width * image.bounding_box.height
	  return {:red => red/num_pixels, :green => green/num_pixels, :blue => blue/num_pixels}  
	end

	# Find the difference between one color and another.	
	def color_difference(rgb1, rgb2)
	  red, green, blue = rgb1[:red] - rgb2[:red], rgb1[:green] - rgb2[:green], rgb1[:blue] - rgb2[:blue]
	  Math.sqrt((red * red) + (green * green) + (blue * blue))
	end

	# Create an array of average color values and return the closest match value
	def match_photo(pixel,average_colors)
	  ave = average_colors.collect { |color|  color_difference(pixel, color)}
	  ave.index(ave.min)
	end

end