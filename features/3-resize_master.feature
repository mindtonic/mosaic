Feature: SysAdmin Resizes Master

The SysAdmin resizes the master image to
the right size for the final lennon image

Scenario: resize_image! when the image is smaller than the maximums
	Given I have a Master Image Instance
	And I have a Small Master Image
	And a Maximum Width
	And a Maximum Height
	When I Resize the Master
	Then the image should not be wider than the Maximum Width
	And the image should not be taller than the Maximum Height 

Scenario: resize_image! when the image is larger than the maximums
	Given I have a Master Image Instance
	And I assign a Large Master Image
	And a Maximum Width
	And a Maximum Height
	When I Resize the Master
	Then the image should not be wider than the Maximum Width
	And the image should not be taller than the Maximum Height 