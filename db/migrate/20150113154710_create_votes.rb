class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :initiative, index: true
      t.references :user, index: true
      t.string :vtype 

      t.timestamps null: false
    end
  end
end
