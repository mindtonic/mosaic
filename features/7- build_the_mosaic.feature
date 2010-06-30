Feature: Create The Mosaic

Use all of the resources collected so far and build the Mosaic image

Scenario: Build the Mosaic
	Given I have a Small Master Image
	And I have a Source
	And I have a testing Mosaic
	When I Create the Mosaic
	And I Save the Mosaic
	Then mosaic.jpg should be saved to the filesystem
	And I should see "-- Building Mosaic"
	And I should see "-- Saving Mosaic"
