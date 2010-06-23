Feature: Build Master Image

The Master Image is built into an Image Magick Object

Scenario: canvas_factory builds the Master Image Object
	Given I have an Image Instance
	And I have a Master Image
	When I Download the Image
	Then the Image should have a canvas object