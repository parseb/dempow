class AddRefsToComments < ActiveRecord::Migration
  	def change
  		add_reference :comments, :initiative, index: true
	end
end
