module Mosaic 
  class Admin
  	require 'open-uri'
  	require 'hpricot'
  	require 'RMagick'
		include Magick
		
  	attr_accessor :master, :source, :maximum_width, :maximum_height, :canvas, :tiles
  
    def initialize(master, source)
      @master = master
      @source = source
	    @maximum_width = 1000
	    @maximum_height = 1000
	    @tiles = Array.new
    end
    
    def resize_master!
    	@canvas = ImageList.new(@master)
    	@canvas.change_geometry!("#{@maximum_width}x#{@maximum_height}") {|cols, rows, img| img.resize!(cols, rows)}
    end
    
    def pull_tiles
    	(Hpricot::XML(open(@source))/"enclosure").each {|z| @tiles << Mosaic::Image.new(z.attributes['url'])}
    end
  end
end

