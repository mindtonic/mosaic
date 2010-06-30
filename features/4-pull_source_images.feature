Feature: Pull Source Images

Collects all of the Images for a Source

Scenario: pull_images collects the lennon images
	Given I have the address for a Feed of Images
	And I have a Source
	When I Pull the Images
	Then the Source should have Images
	And they should be Lennon::Image Objects