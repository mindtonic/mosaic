# Find these tests placed into #7 so that the entire creation process is only run once
#
#
# Feature: Mosaic Creation and Saving Feedback
# 
# When creating and saving the mosaic, you should get feedback
# 	
# Scenario: Build the Mosaic
# 	Given I have a Small Master Image
# 	And I have a Source
# 	When I Create the Mosaic
# 	And I Save the Mosaic
# 	Then I should see "-- Building Mosaic"
# 	And I should see "-- Saving Mosaic"