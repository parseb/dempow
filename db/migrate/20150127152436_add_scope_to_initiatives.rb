class AddScopeToInitiatives < ActiveRecord::Migration
  def change
  	add_column :initiatives, :scope, :string
  end
end
