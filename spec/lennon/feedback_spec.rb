require File.join(File.dirname(__FILE__), "/../spec_helper")

module Lennon
  describe Feedback do

		before(:each) do
      @feedback = Lennon::Feedback.instance
		end
		
		context "singleton" do
			it "should only have one instance" do
				@feedback.should be == Lennon::Feedback.instance
			end
		end
		
		context "messages" do
			it "Should define the messages variable" do
				@feedback.messages.should_not be nil
			end
			
			it "Should define the messages variable as an Array" do
				@feedback.messages.should be_a_kind_of Array
			end
		end
		
		context "puts" do
			before(:each) do
				@length = @feedback.messages.length
				@feedback.puts "Testing the messages queue"		
			end
		
			it "Should add a new message to the messages variable" do
				@feedback.messages.length.should be == (@length += 1)
			end
			
			it "Should contain the new message" do
				@feedback.messages.should include("Testing the messages queue")
			end
		end
		
		context "print_to_console" do
			it "Should start out as false" do
				@feedback.print_to_console.should be == false
			end
			
			it "Should become true when triggered" do
				@feedback.print_to_console!
				@feedback.print_to_console.should be == true
			end
			
			it "Should become false when triggered" do
				@feedback.no_print_to_console!
				@feedback.print_to_console.should be == false
			end
		end
  
  end
end