Feature: Gets Average Color

The Lennon::Image downloads the actual image and calculates the average color of the Image.  Both the Downloaded Image and the Average Color are stored in the model for future reference.
	
Scenario: calculate_average_color gets the average color of the canvas
	Given I have an Image
	And a canvas
	When I call calculate_average_color
	Then the Image should have a value for average_colors