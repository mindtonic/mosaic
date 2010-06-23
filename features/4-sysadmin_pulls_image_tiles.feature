Feature: SysAdmin Pulls Image Tiles

The SysAdmin pulls an array of URL's from a predefined source.

Scenario: pull_tiles collects the mosaic image tiles
	Given I have a Mosaic Instance
	And a Tile Source
	When I Pull the Tiles
	Then the system should have Tiles
	And they should be an Array
	And there should be more than one Tile
	And they should be MosaicImage Objects