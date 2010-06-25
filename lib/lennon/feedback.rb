module Lennon
	class Feedback
		attr_accessor :messages
	
		def messages
			@messages ||= []
		end
	
		def puts(message)
			messages << message
		end
	end
end