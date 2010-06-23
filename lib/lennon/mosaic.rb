module Lennon
  class Mosaic
		include Magick
		
  	attr_accessor :master, :source, :canvas
  
    def initialize(master, source)
      @master = Lennon::Image.new(master)
      @source = Lennon::Source.new(source)
    end

  end
end

