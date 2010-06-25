#
# Helpers
#

def location
	@location ||= "tmp/ruby.jpg"
end

def address
	@address ||= "tmp/feed.xml"	
end      

def lennon
  @lennon ||= Lennon::Mosaic.new(location, address)
end

def image
	@image ||= lennon.master
end

def source
	@source ||= lennon.source
end

def feedback 
	@feedback ||= lennon.feedback
end

def check_pixel_value(pixel, value)
	pixel[value].should_not be nil
	pixel[value].should be >= 0
end

#
# Given
#

Given /^I have a Master Image$/ do
	location
end

Given /^I have a Small Master Image$/ do
  @location = "tmp/john_lennon.jpg"
end

Given /^I have a Feed of Images$/ do
	address
end

Given /^I have an Image Instance$/ do
  image
end

Given /^I assign a Large Master Image$/ do
  image.location = "tmp/large_ruby.jpg"
end

Given /^a Maximum Width$/ do
  image.maximum_width.should_not be nil
end

Given /^a Maximum Height$/ do
  image.maximum_height.should_not be nil
end

Given /^I have a Source Instance$/ do
  source
end

Given /^a canvas$/ do
  image.canvas_factory
end

Given /^I have a small image size for easier testing$/ do
	image.maximum_width = 10
	image.maximum_height = 10
end

Given /^I have prepared the Master$/ do
  lennon.prepare_the_master
end

Given /^I have Prepared the Source Images$/ do
  lennon.prepare_the_source_images
end



#
# When
#

When /^I build a new lennon$/ do
  lennon
end

When /^I Download the Image$/ do
  image.canvas_factory
end

When /^I Resize the Master$/ do
  image.resize!
end

When /^I Pull the Images$/ do
	source.source_code = File.open('tmp/feed.xml')
  source.pull_images
end

When /^I call calculate_average_color$/ do
  image.calculate_average_color
end

When /^I create_pixel_array$/ do
  image.create_pixel_array
end

When /^I Create the Mosaic$/ do
  lennon.create_mosaic
end

When /^I Save the Mosaic$/ do
  lennon.save
end


#
# Then
#

Then /^Mosaic should have a Master Image$/ do
	lennon.master.should_not be nil
	lennon.master.should be_a_kind_of Lennon::Image
end

Then /^Mosaic should have a Source of Images$/ do
	lennon.source.should_not be nil
	lennon.source.should be_a_kind_of Lennon::Source
end

Then /^the Image should have a canvas object$/ do
	image.canvas.should_not be nil
	image.canvas.should be_a_kind_of Magick::ImageList
end

Then /^the image should not be wider than the Maximum Width$/ do
  image.canvas[0].rows.should be <= image.maximum_width
end

Then /^the image should not be taller than the Maximum Height$/ do
  image.canvas[0].columns.should be <= image.maximum_height
end

Then /^the Source should have Images$/ do
  source.images.should_not be nil
end

Then /^they should be an Array of Images$/ do
  source.images.should be_a_kind_of Array
end

Then /^there should be more than one Image$/ do
  source.images.length.should be > 0
end

Then /^they should be Lennon::Image Objects$/ do
  source.images.each {|image| image.should be_a_kind_of Lennon::Image}
end

Then /^the Image should have a value for average_colors$/ do
  image.average_color.should_not be nil
end

Then /^it should be a Hash$/ do
  image.average_color.should be_a_kind_of Hash
end

Then /^the Hash should have a value for Red$/ do
	check_pixel_value(image.average_color, :red)
end

Then /^the Hash should have a value for Green$/ do
  check_pixel_value(image.average_color, :green)
end

Then /^the Hash should have a value for Blue$/ do
  check_pixel_value(image.average_color, :blue)
end

Then /^the Image should have a pixel_array$/ do
  image.pixel_array.should_not be nil
end

Then /^they should be an Array of pixels$/ do
	image.pixel_array.should be_a_kind_of Array
end

Then /^they should be an Array of average_color Hashes$/ do
  for pixels in image.pixel_array
  	pixels.should be_a_kind_of Hash
  	check_pixel_value(pixels, :red)
  	check_pixel_value(pixels, :green)
  	check_pixel_value(pixels, :blue)
  end
end

Then /^mosaic\.jpg should be saved to the filesystem$/ do
  File.exist?("mosaic.jpg").should be true
end

Then /^I should see "([^"]*)"$/ do |message| #"
  feedback.messages.should include(message)
end

