Feature: SysAdmin Instates the Class

	As a sysadmin
	I want to start mosaic 
	So that I can perform duties

	Scenario: start mosaic
		Given I am a SysAdmin
		And I have a Master Image
		And I have a Feed of Images
		When I build a new mosaic
		Then Mosaic should have a Master Image
		And Mosaic should have a Source of Images 