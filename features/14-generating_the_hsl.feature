Feature: Generating the HSL Value for an Image

Creating the HSL value for an Image
	
Scenario: Create the HSL value for an image
	Given I have an Image Instance
	And a canvas
	When I call calculate_hsl
	Then the Image should have a value for hsl
