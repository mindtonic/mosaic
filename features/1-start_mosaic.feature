Feature: Start the Mosaic Class

	What happens when you first start the Class

	Scenario: start lennon
		Given I have a Master Image
		And I have a Feed of Images
		When I build a new lennon
		Then Mosaic should have a Master Image
		And Mosaic should have a Source of Images