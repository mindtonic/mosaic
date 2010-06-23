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
      
      it "should assign a value to the object"
    end

  end
end