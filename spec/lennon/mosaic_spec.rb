require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Mosaic do
  
		before(:each) do
      @image = "tmp/ruby.jpg"
      @source = "tmp/feed.xml"
      @admin = Lennon::Mosaic.new(@image, @source)
		end
		   
    context "initialization" do 
    
    	context "the master parameter" do
	      it "should assign a value for the master" do
	        @admin.master.should_not be nil
	      end
	      
	      it "should have the same value as @image" do
	      	@admin.master.should be_a_kind_of Lennon::Image
	      end
	    end
	    
	    context "the source parameter" do
	      it "should assign a value for the source" do
	        @admin.source.should_not be nil
	      end
	      
	      it "should be a Lennon::Source object" do
	      	@admin.source.should be_a_kind_of Lennon::Source
	      end
	    end

			context "coupled testing" do
				it "Lennon::Image.location should be the same as @image" do
					@admin.master.location.should == @image
				end
			
				it "Lennon::Source.address should be the same as @source" do
					@admin.source.address.should be == @source
				end
			end
	    
    end
     
  end
end