Feature: Pull Source Images

Collects all of the Images for a Source

Scenario: pull_images collects the lennon images
	Given I have a Source Instance
	And I have a Feed of Images
	When I Pull the Images
	Then the Source should have Images
	And they should be an Array
	And there should be more than one Image
	And they should be Lennon::Image Objects