Feature: Running The Program From Command Line

Running the entire thing from the command line
	
Scenario: Build the Mosaic
	Given I have a Small Master Image
	And I have a Source
	And I have a testing Mosaic
	When I Run the program from the command line
	Then I should see "Welcome to the Lennon Mosaic!"
	And I should see "-- Building Mosaic"
	And I should see "-- Saving Mosaic"
	And I should see "-- Downloading Image"
	And I should see "-- Resizing Image"
	And I should see "-- Collecting Image Pixels"
	And I should see "-- Calculating Average Color"
	And mosaic.jpg should be saved to the filesystem