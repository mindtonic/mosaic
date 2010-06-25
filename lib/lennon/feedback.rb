require 'singleton'

module Lennon
	class Feedback
		include Singleton
	
		attr_accessor :messages
	
		def messages
			@messages ||= []
		end
	
		def puts(message)
			messages << message
		end
	end
end

module LennonReporting
	def report(message)
		Lennon::Feedback.instance.puts message
	end
end