module Mosaic 
  class Admin
		include Magick
		
  	attr_accessor :master, :source, :canvas
  
    def initialize(master, source)
      @master = Mosaic::Image.new(master)
      @source = Mosaic::Source.new(source)
    end

  end
end

