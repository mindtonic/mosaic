module Mosaic 
  class Image
  	require 'open-uri'
  	require 'RMagick'
		include Magick
		
  	attr_accessor :location, :object
  
  	def initialize(location)
  		@location = location
  	end
  
 	end
end