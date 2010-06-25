$: << File.join(File.dirname(__FILE__), "/../lib")
require 'spec'
require 'lennon'

def test_image
	"tmp/ruby.jpg"
end

def test_feed
	"tmp/feed.xml"
end

def build_mosaic
  @image ||= test_image
  @source ||= test_feed
  @mosaic ||= Lennon::Mosaic.new(@image, @source)  
end

def build_full_mosaic
	build_mosaic
	@mosaic.master.maximum_width = 5
	@mosaic.master.maximum_height = 5
	@mosaic.prepare_the_master
	@mosaic.prepare_the_source_images
end

def image_boundaries_required(image)
	image.maximum_width.should_not be nil
	image.maximum_height.should_not be nil
end

def image_within_size_boundaries(image)
	image.canvas[0].rows.should be <= image.maximum_width
	image.canvas[0].columns.should be <= image.maximum_height
end

def check_all_pixels(pixel)
	check_pixel_value(pixel, :red)
	check_pixel_value(pixel, :green)
	check_pixel_value(pixel, :blue)		
end

def check_pixel_value(pixel, value)
	pixel[value].should_not be nil
	pixel[value].should be >= 0
end

def make_testing_image
	@image.maximum_width = 10
	@image.maximum_height = 10
	@image.canvas_factory		
end