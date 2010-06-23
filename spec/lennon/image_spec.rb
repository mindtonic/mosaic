require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Image do

		before(:each) do
      @image = Lennon::Image.new("tmp/ruby.jpg")
		end
		
    context "initializing" do 
      it "should assign a value for the URL" do
        @image.location.should_not be nil
      end
      
      it "should not assign a value to the canvas" do
      	@image.canvas.should be nil
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
    		@image.canvas[0].rows.should be <= @image.maximum_width
    		@image.canvas[0].columns.should be <= @image.maximum_width
    	end
    end
    
    context "resizing the image with a large image" do
			before(:each) do
    		@image.location = "tmp/large_ruby.jpg"
    		@image.resize!
			end  
    	
    	it "the image should fit the defined parameters" do
    		@image.canvas[0].rows.should be <= @image.maximum_width
    		@image.canvas[0].columns.should be <= @image.maximum_height
    	end
    end
    
    context "calculate_average_color" do
			before(:each) do
				@image.maximum_width = 10
				@image.maximum_height = 10
    		@image.canvas_factory
    		@image.calculate_average_color
			end
			
      it "should assign a value to the average_colors" do
      	@image.average_colors.should_not be nil
      	@image.average_colors.should be_a_kind_of Hash
      	check_pixel_value(@image.average_colors, :red)
      	check_pixel_value(@image.average_colors, :green)
      	check_pixel_value(@image.average_colors, :blue)
      end     	
    end

    context "create_pixel_array" do
			before(:each) do
				@image.maximum_width = 10
				@image.maximum_height = 10
    		@image.canvas_factory
    		@image.create_pixel_array
			end
			
      it "should assign a value to the pixel_array" do
      	@image.pixel_array.should_not be nil
      	@image.pixel_array.should be_a_kind_of Array
      	for pixel in @image.pixel_array
      		pixel.should be_a_kind_of Hash
      		check_pixel_value(pixel, :red)
      		check_pixel_value(pixel, :green)
      		check_pixel_value(pixel, :blue)
      	end
      end     	
    end

		#
		# UTILITIES
		#
    
		def check_pixel_value(pixel, value)
			pixel[value].should_not be nil
			pixel[value].should be >= 0
		end

  end
end