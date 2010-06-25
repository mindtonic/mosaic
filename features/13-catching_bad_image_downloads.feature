Feature: Catching Bad Image Downloads

What happens when a Source Image download fails?  It shouldn't crash the party!
	
Scenario: Catch Bad Downloads From Within The Source
	Given I have a Feed of Images with some Bad Entries
	When I Pull the Images
	Then no errors should be raised
