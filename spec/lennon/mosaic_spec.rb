require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Mosaic do
  
		before(:each) do
      mosaic
		end
		   
    context "initialization" do     
    	context "the master parameter" do
	      it "should assign a value for the master" do
	        @mosaic.master.should_not be nil
	      end
	      
	      it "should have the same value as @image" do
	      	@mosaic.master.should be_a_kind_of Lennon::Master
	      end
	    end
	    
	    context "the source parameter" do
	      it "should assign a value for the source" do
	        @mosaic.source.should_not be nil
	      end
	      
	      it "should be a Lennon::Source object" do
	      	@mosaic.source.should be_a_kind_of Lennon::Source
	      end
	    end
	    
	    context "the feedback object" do
	      it "should assign a value for the source" do
	        @mosaic.feedback.should_not be nil
	      end
	      
	      it "should return a startup message" do
	      	test_feedback("Welcome to the Lennon Mosaic!")
	      end
	    end

			context "coupled testing" do
				it "Lennon::Image.location should be the same as @image" do
					@mosaic.master.location.should == location
				end
			
				it "Lennon::Source.address should be the same as @source" do
					@mosaic.source.address.should be == address
				end
			end
    end
    
    context "Catching Errors" do
			before(:each) do
				@mosaic.source.address = "tmp/feed_bad.xml"
			end
			
			it "Should not raise an error" do
				lambda {@mosaic.prepare_the_source_images}.should_not raise_error
			end
			
			it "Should have 2 less entries" do
				@mosaic.prepare_the_source_images
				@mosaic.source.images.length.should be == (Hpricot::XML(File.open(@mosaic.source.address))/"enclosure").length - 2
			end
    end

    context "find_best_image" do
    	before(:all) do
    		build_full_mosaic
    		@master = @mosaic.master
    		@images = @mosaic.source.images
    		@master_pixel = @master.pixel_array.first
    		@mosaic.feedback.print_to_console!
    		@best_image = @mosaic.find_best_image(@master_pixel)
    		@mosaic.feedback.no_print_to_console!
    	end
			
			it "Best Image should be a Lennon::Image" do
				@best_image.should be_a_kind_of Lennon::Image
			end
			
			it "Best Image should be the image with the lowest difference" do
				diffs = []
				@images.each {|image| diffs << @mosaic.color_difference(@master_pixel, image.average_color)}
				@images[diffs.index(diffs.min)].should be == @best_image
			end
    end
    
    context "color_difference" do
    	before(:all) do
    		build_full_mosaic
    		@master = @mosaic.master
    		@images = @mosaic.source.images
    		@master_pixel_color = @master.pixel_array.first
    		@image_pixel_color = @mosaic.source.images.first.average_color
    	end
    	
    	it "Should return an RBG value for @master_pixel_color" do
    		@master_pixel_color.should be_a_kind_of Hash
    		check_all_pixels(@master_pixel_color)
    	end

    	it "Should return an RBG value for @image_pixel_color" do
    		@image_pixel_color.should be_a_kind_of Hash
    		check_all_pixels(@master_pixel_color)
    	end    	
		end
    
    context "create_mosaic" do
    	before(:all) do
				mosaic
				@mosaic.master.maximum_width = 5
				@mosaic.master.maximum_height = 5
    		@mosaic.feedback.print_to_console!
    		@mosaic.create_mosaic
    		@mosaic.feedback.no_print_to_console!
    	end
    	
			it "Should set a value to mosaic_images" do
				@mosaic.mosaic_images.should_not be nil
			end
			
			it "Should be an Image List" do
				@mosaic.mosaic_images.should be_a_kind_of Magick::ImageList
			end
			
      it "should provide valuable feedback" do
      	test_feedback("-- Building Mosaic")
      	test_feedback("-- Mosaic Built")
      end 
    end
    
    context "save_mosaic" do
    	before(:all) do
    		remove_mosaic_file
				mosaic
				@mosaic.master.maximum_width = 5
				@mosaic.master.maximum_height = 5
				@mosaic.feedback.print_to_console!
    		@mosaic.create_mosaic
    		@mosaic.save
    		@mosaic.feedback.no_print_to_console!
    	end
    	
			it "Should save a file called mosaic.jpg" do
				File.exist?("mosaic.jpg").should be true
			end
			
      it "should provide valuable feedback" do
      	test_feedback("-- Saving Mosaic")
      end   
    end
    
    context "imagine!" do
    	before(:all) do
    		remove_mosaic_file
				@mosaic = Lennon::Mosaic.new(location, address)
				@mosaic.master.maximum_width = 5
				@mosaic.master.maximum_height = 5
				@mosaic.feedback.print_to_console!
				@mosaic.imagine!
				@mosaic.feedback.no_print_to_console!
    	end
    	
			it "Should save a file called mosaic.jpg" do
				File.exist?("mosaic.jpg").should be true
			end
			
      it "should provide valuable feedback" do
      	test_feedback("....... Imagining A Mosaic! .......")
      	test_feedback("....... All Done! .......")
      end
    end
     
  end
end