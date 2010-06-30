Feature: Source Feedback

When processing the source, you should get feedback
	
Scenario: download_image collects the image
	Given I have an Image
	When I Download the Image
	Then I should see "-- Downloading Image"
	
Scenario: calculate_average_color gets the average color of the canvas
	Given I have an Image
	And a canvas
	When I call calculate_average_color
	Then I should see "-- Calculating Average Color"