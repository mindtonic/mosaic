require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Master do

		before(:each) do
      master
		end
		
    context "initializing" do 
      it "should assign a value for the URL" do
        @master.location.should_not be nil
      end
      
      it "should not assign a value to the canvas" do
      	@master.canvas.should be nil
      end
      
	    it "should have maximum parameters" do
	    	image_boundaries_required(@master)
	    end
    end
    
    context "canvas_factory" do
			before(:each) do
		    @master.canvas_factory
			end
		
      it "should assign a value to the canvas" do
      	@master.canvas.should_not be nil
      	@master.canvas.should be_a_kind_of Magick::ImageList
      end    
      
      it "should provide valuable feedback" do
      	test_feedback("-- Downloading Image")
      end  
    end
    
    context "resizing the image with a small image" do
			before(:each) do
				@master.location = "tmp/john_lennon.jpg"
    		@master.resize!
			end
    	
    	it "the image should fit the defined parameters" do
    		image_within_size_boundaries(@master)
    	end
    end
    
    context "resizing the image with a large image" do
			before(:each) do
    		@master.location = "tmp/large_ruby.jpg"
    		@master.resize!
			end  
    	
    	it "the image should fit the defined parameters" do
    		image_within_size_boundaries(@master)
    	end
    	
      it "should provide valuable feedback" do
      	test_feedback("-- Resizing Image")
      end 
    end

    context "create_pixel_array" do
			before(:each) do
				make_master_testing_image
    		@master.create_pixel_array
			end
			
      it "should assign a value to the pixel_array" do
      	@master.pixel_array.should_not be nil
      	@master.pixel_array.should be_a_kind_of Array
      	for pixel in @master.pixel_array
      		pixel.should be_a_kind_of Hash
      		check_all_pixels(pixel)
      	end
      end
      
      it "should provide valuable feedback" do
      	test_feedback("-- Collecting Image Pixels")
      end     	
    end

		context "Catching Errors" do
			before(:each) do
				@master.location = "i_do_not_exist.gif"
			end
			
			it "Should throw an error" do
				lambda {@master.canvas_factory}.should raise_error
			end
		end
  end
end