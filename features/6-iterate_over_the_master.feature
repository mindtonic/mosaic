Feature: Collect The Master Pixels

Collect all of the pixels from the Master into an Array.

Scenario: create_pixel_array collects the master pixels
	Given I have a Small Master Image
	When I create_pixel_array
	Then the Image should have a pixel_array
	