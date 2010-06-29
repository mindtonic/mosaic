$: << File.join(File.dirname(__FILE__), "/../lib")
require 'spec'
require 'lennon'

def location
	@location ||= "tmp/Lennon.png"
end

def address
	@address ||= "tmp/feed.xml"	
end

def mosaic
	@mosaic ||= Lennon::Mosaic.new(location, address)
end

def master
	@master ||= mosaic.master
end

def image
	@image ||= Lennon::Image.new(location)
end

def source
	@source ||= mosaic.source
end

def feedback 
	@feedback ||= mosaic.feedback
end

def build_full_mosaic
	mosaic
	@mosaic.master.maximum_width = 5
	@mosaic.master.maximum_height = 5
	@mosaic.feedback.print_to_console!
	@mosaic.prepare_the_master
	@mosaic.prepare_the_source_images
	@mosaic.feedback.no_print_to_console!
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

def make_master_testing_image
	@master.maximum_width = 10
	@master.maximum_height = 10
	@master.canvas_factory	
end

def remove_mosaic_file
	File.unlink("mosaic.jpg") if File.exist?("mosaic.jpg")
end

def test_feedback(message)
	Lennon::Feedback.instance.messages.should include(message)
end