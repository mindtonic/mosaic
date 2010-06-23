module Lennon
  class Mosaic
		include Magick
		
  	attr_accessor :master, :source, :canvas
  
    def initialize(master, source)
      @master = Lennon::Image.new(master)
      @source = Lennon::Source.new(source)
    end

# 		# Find the difference between one color and another.	
# 		def color_difference(rgb1, rgb2)
# 		  red, green, blue = rgb1[:red] - rgb2[:red], rgb1[:green] - rgb2[:green], rgb1[:blue] - rgb2[:blue]
# 		  Math.sqrt((red * red) + (green * green) + (blue * blue))
# 		end
# 	
# 		# Create an array of average color values and return the closest match value
# 		def match_photo(pixel,average_colors)
# 		  ave = average_colors.collect { |color|  color_difference(pixel, color)}
# 		  ave.index(ave.min)
# 		end

# 		# Create the image Mosaic
# 		def create_mosaic
# 			tile_size = 40
# 			mosaic_images = ImageList.new
# 			tile = Rectangle.new(tile_size,tile_size,0,0)
# 			photo_tiles.scene = 0
# 			num = 0
# 			master.bounding_box.height.times do |row|
# 			  master.bounding_box.width.times do |col|
# 			    idx = match_photo(pixel_array[num], average_colors)
# 			    mosaic_images << photo_tiles[idx].crop_resized(tile_size,tile_size)
# 			    tile.x = col * mosaic_images.columns
# 			    tile.y = row * mosaic_images.rows
# 			    mosaic_images.page = tile
# 			    (photo_tiles.scene += 1) rescue photo_tiles.scene = 0    
# 			    num = num.next
# 			  end
# 			end	
# 		end

  end
end

