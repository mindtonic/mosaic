require File.join(File.dirname(__FILE__), "/../spec_helper")

module Mosaic
  describe Image do

		before(:each) do
      @image = Mosaic::Image.new("tmp/ruby.jpg")
		end
		
    context "initializing" do 
      it "should assign a value for the URL" do
        @image.location.should_not be nil
      end
      
      it "should not assign a value to the magick" do
      	@image.magick.should be nil
      end
      
	    context "the maximum parameter" do
	    	it "maximum_width should be assigned" do
	    		@image.maximum_width.should_not be nil
	    	end
	    	
	    	it "maximum_height should be assigned" do
	    		@image.maximum_height.should_not be nil
	    	end
	    end
    end
    
    context "magick_factory" do
			before(:each) do
		    @image.magick_factory
			end
		
      it "should assign a value to the magick" do
      	@image.magick.should_not be nil
      end
      
      it "should be an ImageList" do
      	@image.magick.should be_a_kind_of Magick::ImageList
      end    
    end
    
    context "resizing the image with a small image" do
			before(:each) do
    		@image.resize!
			end
    	
    	it "the image should not be wider than the maximum_width" do
    		@image.magick[0].rows.should be <= @image.maximum_width
    	end
    	
    	it "the image should not be taller than the maximum_height" do 
    		@image.magick[0].columns.should be <= @image.maximum_width
    	end
    end
    
    context "resizing the image with a large image" do
			before(:each) do
    		@image.location = "tmp/large_ruby.jpg"
    		@image.resize!
			end  
    	
    	it "the image should not be wider than the maximum_width" do
    		@image.magick[0].rows.should be <= @image.maximum_width
    	end
    	
    	it "the image should not be taller than the maximum_height" do 
    		@image.magick[0].columns.should be <= @image.maximum_width
    	end
    end

  end
end