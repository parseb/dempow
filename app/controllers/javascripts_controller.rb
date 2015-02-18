class JavascriptsController < ApplicationController

	protect_from_forgery except: :dynamic_states

	def dynamic_states
		@localities = Locality.all 	
	end

end
