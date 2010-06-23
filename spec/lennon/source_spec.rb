require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Source do

		before(:each) do
      @source = Lennon::Source.new("tmp/feed.xml")
		end
		
    context "initializing" do 
      it "should assign a value for the address" do
        @source.address.should_not be nil
      end
    end
    
    context "open_sesame" do
	    before(:each) do
	      @source.address = "http://blog.mindtonic.net/feed/"
	      @source.open_sesame
			end
    
    	it "should assign a value to source_code" do
    		@source.source_code.should_not be nil
    	end
    end
    
    context "pull_images" do
			before(:each) do
				@source.source_code = File.open('tmp/feed.xml')
    		@source.pull_images
			end
			
    	it "should assign a value to source_code" do
    		@source.source_code.should_not be nil
    	end
    	
    	it "should assign an array to images" do
    		@source.images.should be_a_kind_of Array
    	end
    	
    	it "should have more than one tile" do
    		@source.images.length.should be > 0
    	end
    	
    	it "should be an array of LennonImage Objects" do
    		@source.images.each {|image| image.should be_a_kind_of Lennon::Image}
    	end
    	
    	it "should have 60 images" do
    		@source.images.length.should be == 100
    	end 
    end
	
	end
end