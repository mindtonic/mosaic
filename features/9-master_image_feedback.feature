Feature: Master Image Feedback

When processing the master image, you should get feedback

Scenario: Building Master Image Object
	Given I have a Small Master Image
	When I Download the Image
	Then I should see "-- Downloading Image"

Scenario: resize_image! when the image is smaller than the maximums
	Given I have a Small Master Image
	When I Resize the Image
	Then I should see "-- Resizing Image"

Scenario: resize_image! when the image is larger than the maximums
	Given I have a Large Master Image
	When I Resize the Image
	Then I should see "-- Resizing Image"
	
Scenario: canvas_factory builds the Master Image Object
	Given I have a Small Master Image
	When I create_pixel_array
	Then I should see "-- Collecting Image Pixels"