Feature: Gets Average Color

The Lennon::Image downloads the actual image and calculates the average color of the Image.  Both the Downloaded Image and the Average Color are stored in the model for future reference.

Scenario: download_image collects the image
	Given I have an Image Instance
	When I Download the Image
	Then the Image should have a canvas object
	
Scenario: calculate_average_color gets the average color of the canvas
	Given I have an Image Instance
	And a canvas
	When I call calculate_average_color
	Then the Image should have a value for average_colors
	And it should be a Hash
	And the Hash should have a value for Red
	And the Hash should have a value for Green
	And the Hash should have a value for Blue