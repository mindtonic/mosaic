require File.join(File.dirname(__FILE__), "/../spec_helper")

module Mosaic
  describe Admin do
  
		before(:each) do
      @image = "tmp/ruby.jpg"
      @source = "tmp/feed.xml"
      @admin = Mosaic::Admin.new(@image, @source)
		end
		   
    context "initialization" do 
    
    	context "the master parameter" do
	      it "should assign a value for the master" do
	        @admin.master.should_not be nil
	      end
	      
	      it "should have the same value as @image" do
	      	@admin.master.should be_a_kind_of Mosaic::Image
	      end
	    end
	    
	    context "the source parameter" do
	      it "should assign a value for the source" do
	        @admin.source.should_not be nil
	      end
	      
	      it "should be a Mosaic::Source object" do
	      	@admin.source.should be_a_kind_of Mosaic::Source
	      end
	    end

			context "coupled testing" do
				it "Mosaic::Image.location should be the same as @image" do
					@admin.master.location.should == @image
				end
			
				it "Mosaic::Source.address should be the same as @source" do
					@admin.source.address.should be == @source
				end
			end
	    
    end
     
  end
end