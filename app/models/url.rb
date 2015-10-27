class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	before_create :shorten

	def shorten
		range = [*'0'..'9',*'A'..'Z',*'a'..'z']

		@short_url = (0...6).map{ range.sample }.join
		self.short_url = @short_url
	end
end
