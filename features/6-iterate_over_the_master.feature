Feature: Collect The Master's Pixels

Collect all of the pixels from the Master into an Array.

Scenario: canvas_factory builds the Master Image Object
	Given I have an Image Instance
	And I have a Master Image
	And I have a small image size for easier testing
	When I create_pixel_array
	Then the Image should have a pixel_array
	And they should be an Array of pixels
	And they should be an Array of average_color Hashes
	