Feature: Build Master Image

The Master Image is built into an Image Magick Object

Scenario: magick_factory builds the Master Image Object
	Given I have an Image Instance
	And I have a Master Image
	When I Build the Magick Master
	Then the Image should have a magick object