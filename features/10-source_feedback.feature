Feature: Source Feedback

When processing the source, you should get feedback
	
Scenario: download_image collects the image
	Given I have an Image Instance
	When I Download the Image
	Then I should see "-- Downloading Image"
	And I should see "-- Image Downloaded"
	
Scenario: calculate_average_color gets the average color of the canvas
	Given I have an Image Instance
	And a canvas
	When I call calculate_average_color
	Then I should see "-- -- Calculating Average Color"
	And I should see "-- -- Average Color Calculated"