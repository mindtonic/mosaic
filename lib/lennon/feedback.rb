require 'singleton'

module Lennon
	class Feedback
		include Singleton
	
		attr_accessor :messages, :print_to_console
		
		@print_to_console = false
	
		def messages
			@messages ||= []
		end
	
		def puts(message)
			messages << message
			output message
		end
		
		def output(message)
			STDOUT.puts message if print_to_console
		end
	
		def print_to_console
			@print_to_console ||= false
		end
		
		def print_to_console!
			@print_to_console = true
		end
		
		def no_print_to_console!
			@print_to_console = false
		end
	end
end

module LennonReporting
	def report(message)
		Lennon::Feedback.instance.puts message
	end
end