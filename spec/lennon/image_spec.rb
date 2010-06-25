require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Image do

		before(:each) do
      @image = Lennon::Image.new(test_image)
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
    end
    
    context "resizing the image with a small image" do
			before(:each) do
    		@image.resize!
			end
    	
    	it "the image should fit the defined parameters" do
    		image_within_size_boundaries(@image)
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
    end

  end
end