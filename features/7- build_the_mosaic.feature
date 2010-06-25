Feature: Create The Mosaic

Use all of the resources collected so far and build the Mosaic image

Scenario: Build the Mosaic
	Given I have a Master Image
	And I have a small image size for easier testing
	And I have a Feed of Images
	And a Maximum Width
	And a Maximum Height
	And I have prepared the Master
	And I have Prepared the Source Images
	When I Create the Mosaic
	And I Save the Mosaic
	Then mosaic.jpg should be saved to the filesystem



