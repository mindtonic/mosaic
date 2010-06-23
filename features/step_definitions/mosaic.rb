#
# Helpers
#

def image
	@image ||= "tmp/ruby.jpg"
end

def address
	@address ||= "tmp/feed.xml"	
end      

def mosaic
  @mosaic ||= Mosaic::Admin.new(image, address)
end

def master
	@master ||= Mosaic::Image.new(image)
end

def source
	@source ||= Mosaic::Source.new(address)
end

#
# Given
#

Given /^I have a Master Image$/ do
	image
end

Given /^I have a Feed of Images$/ do
	address
end

Given /^I have an Image Instance$/ do
  master
end

Given /^I assign a Large Master Image$/ do
  master.location = "tmp/large_ruby.jpg"
end

Given /^a Maximum Width$/ do
  master.maximum_width.should_not be nil
end

Given /^a Maximum Height$/ do
  master.maximum_height.should_not be nil
end

Given /^I have a Source Instance$/ do
  source
end

#
# When
#

When /^I build a new mosaic$/ do
  mosaic
end

When /^I Build the Magick Master$/ do
  master.magick_factory
end

When /^I Resize the Master$/ do
  master.resize!
end

When /^I Pull the Images$/ do
	source.source_code = File.open('tmp/feed.xml')
  source.pull_images
end


#
# Then
#

Then /^Mosaic should have a Master Image$/ do
	mosaic.master.should_not be nil
	mosaic.master.should be_a_kind_of Mosaic::Image
end

Then /^Mosaic should have a Source of Images$/ do
	mosaic.source.should_not be nil
	mosaic.source.should be_a_kind_of Mosaic::Source
end

Then /^the Image should have a magick object$/ do
	master.magick.should_not be nil
	master.magick.should be_a_kind_of Magick::ImageList
end

Then /^the image should not be wider than the Maximum Width$/ do
  master.magick[0].rows.should be <= master.maximum_width
end

Then /^the image should not be taller than the Maximum Height$/ do
  master.magick[0].columns.should be <= master.maximum_height
end

Then /^the Source should have Images$/ do
  source.images.should_not be nil
end

Then /^they should be an Array$/ do
  source.images.should be_a_kind_of Array
end

Then /^there should be more than one Image$/ do
  source.images.length.should be > 0
end

Then /^they should be MosaicImage Objects$/ do
  source.images.each {|image| image.should be_a_kind_of Mosaic::Image}
end
