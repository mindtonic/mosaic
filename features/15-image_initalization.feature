Feature: Download and Resize an image during initializiation

Process the image when the Image instance is created

Scenario: Master Initialization
	Given I have the location of an Image
	When I build the Master Image
	Then the Image should have a canvas object
	And the Image should be resized
	And the Image should have a pixel_array
	And the Image should have an hsl_pixel_array
	
Scenario: Image Initialization
	Given I have the location of an Image
	When I build the Image
	Then the Image should have a canvas object
	And the Image should be resized
	And the Image should have a value for average_colors
	And the Image should have a value for hsl