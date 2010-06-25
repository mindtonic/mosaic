require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Image do

		before(:each) do
      image
		end
		
    context "initializing" do 
      it "should assign a value for the URL" do
        @image.location.should_not be nil
      end
      
      it "should not assign a value to the canvas" do
      	@image.canvas.should be nil
      end
      
	    it "should have maximum parameters" do
	    	image_boundaries_required(@image)
	    end
    end
    
    context "canvas_factory" do
			before(:each) do
		    @image.canvas_factory
			end
		
      it "should assign a value to the canvas" do
      	@image.canvas.should_not be nil
      	@image.canvas.should be_a_kind_of Magick::ImageList
      end    
      
      it "should provide valuable feedback" do
      	@mosaic.feedback.messages.should include("-- Downloading Image")
      end  
    end
    
    context "resizing the image with a small image" do
			before(:each) do
				@image.location = "tmp/john_lennon.jpg"
    		@image.resize!
			end
    	
    	it "the image should fit the defined parameters" do
    		image_within_size_boundaries(@image)
    	end
    	
      it "should provide valuable feedback" do
      	@mosaic.feedback.messages.should include("-- Image does not need to be resized")
      end 
    end
    
    context "resizing the image with a large image" do
			before(:each) do
    		@image.location = "tmp/large_ruby.jpg"
    		@image.resize!
			end  
    	
    	it "the image should fit the defined parameters" do
    		image_within_size_boundaries(@image)
    	end
    	
      it "should provide valuable feedback" do
      	@mosaic.feedback.messages.should include("-- Resizing Image")
      end 
    end
    
    context "calculate_average_color" do
			before(:each) do
				make_testing_image
    		@image.calculate_average_color
			end
			
      it "should assign a value to the average_colors" do
      	@image.average_color.should_not be nil
      	@image.average_color.should be_a_kind_of Hash
      	check_all_pixels(@image.average_color)
      end
      
      it "should provide valuable feedback" do
      	@mosaic.feedback.messages.should include("-- Calculating Average Color")
      end     	
    end

    context "create_pixel_array" do
			before(:each) do
				make_testing_image
    		@image.create_pixel_array
			end
			
      it "should assign a value to the pixel_array" do
      	@image.pixel_array.should_not be nil
      	@image.pixel_array.should be_a_kind_of Array
      	for pixel in @image.pixel_array
      		pixel.should be_a_kind_of Hash
      		check_all_pixels(pixel)
      	end
      end
      
      it "should provide valuable feedback" do
      	@mosaic.feedback.messages.should include("-- Collecting Image Pixels")
      end     	
    end

			context "Catching Errors" do
				before(:each) do
					@image.location = "i_do_not_exist.gif"
				end
				
				it "Should throw an error" do
					lambda {@image.canvas_factory}.should raise_error
				end
			
			end

  end
end