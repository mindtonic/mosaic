Feature: Master Image Feedback

When processing the master image, you should get feedback

Scenario: Building Master Image Object
	Given I have a Master Image Instance
	And I have a Master Image
	When I Download the Image
	Then I should see "-- Downloading Image"

Scenario: resize_image! when the image is larger than the maximums
	Given I have a Master Image Instance
	And I assign a Large Master Image
	And a Maximum Width
	And a Maximum Height
	When I Resize the Master
	Then I should see "-- Resizing Image"
	
Scenario: canvas_factory builds the Master Image Object
	Given I have a Master Image Instance
	And I have a Master Image
	And I have a small image size for easier testing
	When I create_pixel_array
	Then I should see "-- Collecting Image Pixels"