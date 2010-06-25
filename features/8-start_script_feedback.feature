Feature: Start the Mosaic Class and Get Feedback

When you first start the class, you should get feedback

Scenario: start lennon
	Given I have a Master Image
	And I have a Feed of Images
	When I build a new lennon
	Then I should see "Welcome to the Lennon Mosaic!"