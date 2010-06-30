Feature: Start the Mosaic Class and Get Feedback

When you first start the class, you should get feedback

Scenario: start lennon
	Given I have the location of a Master Image
	And I have the address for a Feed of Images
	When I build a new lennon
	Then I should see "Welcome to the Lennon Mosaic!"