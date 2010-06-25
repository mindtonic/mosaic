Feature: Running The Program From Command Line

Running the entire thing from the command line
	
Scenario: Build the Mosaic
	Given I have a Master Image
	And I have a small image size for easier testing
	And I have a Feed of Images
	And a Maximum Width
	And a Maximum Height
	When I Run the program from the command line
	Then I should see "Welcome to the Lennon Mosaic!"
	And I should see "-- Building Mosaic"
	And I should see "-- Mosaic Built"
	And I should see "-- Saving Mosaic"
	And I should see "-- Mosaic Saved"
	And I should see "-- Downloading Image"
	And I should see "-- Image Downloaded"
	And I should see "-- Resizing Image"
	And I should see "-- Image Resized"
	And I should see "-- Collecting Image Pixels"
	And I should see "-- Image Pixels Collected"
	And I should see "-- Downloading Image"
	And I should see "-- Image Downloaded"
	And I should see "-- -- Calculating Average Color"
	And I should see "-- -- Average Color Calculated"
	And I should see "-- Building Mosaic"
	And I should see "-- Mosaic Built"
	And I should see "-- Saving Mosaic"
	And I should see "-- Mosaic Saved"
	And mosaic.jpg should be saved to the filesystem