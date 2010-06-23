
#
# Given
#

Given /^I am a SysAdmin$/ do
end

Given /^I have a Master Image$/ do
	image
end

Given /^I have a Feed of Images$/ do
	source
end

Given /^I have a Mosaic Instance$/ do
  mosaic
end

Given /^I assign a Large Master Image$/ do
  mosaic.master = "tmp/large_ruby.jpg"
end

Given /^a Maximum Width$/ do
  mosaic.maximum_width.should_not be nil
end

Given /^a Maximum Height$/ do
  mosaic.maximum_height.should_not be nil
end

Given /^a Tile Source$/ do
  mosaic.source.should_not be nil
end

#
# When
#

When /^I build a new mosaic$/ do
  mosaic
end

When /^I assign a Master Image$/ do
  mosaic.master = "tmp/ruby.jpg"
end

When /^I Resize the Master$/ do
  mosaic.resize_master!
end

When /^I Pull the Tiles$/ do
  mosaic.pull_tiles
end

#
# Then
#

Then /^Mosaic should have a Master Image$/ do
	mosaic.master.should_not be nil
end

Then /^Mosaic should have a Source of Images$/ do
	mosaic.source.should_not be nil
end

Then /^the system should have a Canvas assigned$/ do
  mosaic.canvas.should_not be nil
end

Then /^the Canvas should not be wider than the Maximum Width$/ do
  mosaic.canvas[0].rows.should be <= mosaic.maximum_width
end

Then /^the Canvas should not be taller than the Maximum Height$/ do
  mosaic.canvas[0].columns.should be <= mosaic.maximum_height
end

Then /^the system should have Tiles$/ do
  mosaic.tiles.should_not be nil
end

Then /^they should be an Array$/ do
  mosaic.tiles.should be_a_kind_of Array
end

Then /^there should be more than one Tile$/ do
  mosaic.tiles.length.should be > 0
end

Then /^they should be MosaicImage Objects$/ do
  mosaic.tiles.each {|image| image.should be_a_kind_of Mosaic::Image}
end

#
# Helpers
#


def image
	@image ||= "tmp/ruby.jpg"
end

def source
	@source ||= "tmp/feed.xml"	
end      

def mosaic
  @mosaic ||= Mosaic::Admin.new(image, source)
end

def messages_should_include(message)
  messenger.string.split("\n").should include(message)
end
