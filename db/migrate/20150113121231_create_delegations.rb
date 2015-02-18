class CreateDelegations < ActiveRecord::Migration
  def change
    create_table :delegations do |t|
      t.references :user
      t.references :initiative
      t.integer :to
      t.integer :value

      t.timestamps null: false
    end
  end
end
