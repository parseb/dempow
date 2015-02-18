class AddLocalityAndCountyToUser < ActiveRecord::Migration
  
  	def change
    	remove_column :users, :city, :string
    	add_column :users, :locality, :string
    	add_column :users, :county, :string

    	add_column :initiatives, :locality, :string
    	add_column :initiatives, :county, :string	
    end

end
