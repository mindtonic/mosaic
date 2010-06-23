require File.join(File.dirname(__FILE__), "/../spec_helper")

module Mosaic
  describe Admin do
  
		before(:each) do
      @image = "tmp/ruby.jpg"
      @large_image = "tmp/large_ruby.jpg"
      #@source = "http://feed.photobucket.com/images/rss/feed.rss"
      @source = "tmp/feed.xml"
      @admin = Admin.new(@image, @source)
		end
		   
    context "initialization" do 
    
    	context "the master parameter" do
	      it "should assign a value for the master" do
	        @admin.master.should_not be nil
	      end
	      
	      it "should have the same value as @image" do
	      	@admin.master.should == @image
	      end
	    end
	    
	    context "the source parameter" do
	      it "should assign a value for the source" do
	        @admin.source.should_not be nil
	      end
	      
	      it "should have the same value as @source" do
	      	@admin.source.should == @source
	      end
	    end
      
	    context "the maximum parameter" do
	    	it "maximum_width should be assigned" do
	    		@admin.maximum_width.should_not be nil
	    	end
	    	
	    	it "maximum_height should be assigned" do
	    		@admin.maximum_height.should_not be nil
	    	end
	    end
    
    end
    
    context "resizing the master image with a small image" do
			before(:each) do
    		@admin.master = @image
    		@admin.resize_master!
			end    

    	it "should assign to the canvas variable" do
    		@admin.canvas.should_not be nil
    	end
    	
    	it "the canvas should not be wider than the maximum_width" do
    		@admin.canvas[0].rows.should be <= @admin.maximum_width
    	end
    	
    	it "the canvas should not be taller than the maximum_height" do 
    		@admin.canvas[0].columns.should be <= @admin.maximum_width
    	end
    end
    
    context "resizing the master image with a large image" do
			before(:each) do
    		@admin.master = @large_image
    		@admin.resize_master!
			end    

    	it "should assign to the canvas variable" do
    		@admin.canvas.should_not be nil
    	end
    	
    	it "the canvas should not be wider than the maximum_width" do
    		@admin.canvas[0].rows.should be <= @admin.maximum_width
    	end
    	
    	it "the canvas should not be taller than the maximum_height" do 
    		@admin.canvas[0].columns.should be <= @admin.maximum_width
    	end
    end
    
    context "pulling the image tiles" do
			before(:each) do
    		@admin.pull_tiles
			end 
    
			it "should have a source" do
    		@admin.source.should_not be nil
    	end
    	
    	it "should assign an array to tiles" do
    		@admin.tiles.should be_a_kind_of Array
    	end
    	
    	it "should have more than one tile" do
    		@admin.tiles.length.should be > 0
    	end
    	
    	it "should be an array of MosaicImage Objects" do
    		@admin.tiles.each {|image| image.should be_a_kind_of Mosaic::Image}
    	end
    end  
  end
  
end