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
	
	def lyrics
	"

..............................
Imagine there's no Heaven 
It's easy if you try 
No hell below us 
Above us only sky 
Imagine all the people 
Living for today 

Imagine there's no countries 
It isn't hard to do 
Nothing to kill or die for 
And no religion too 
Imagine all the people 
Living life in peace 

You may say that I'm a dreamer 
But I'm not the only one 
I hope someday you'll join us 
And the world will be as one 

Imagine no possessions 
I wonder if you can 
No need for greed or hunger 
A brotherhood of man 
Imagine all the people 
Sharing all the world 

You may say that I'm a dreamer 
But I'm not the only one 
I hope someday you'll join us 
And the world will live as one
..............................

	"
	end
end