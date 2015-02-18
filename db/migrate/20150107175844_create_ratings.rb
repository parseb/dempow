class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value, default: 0
      t.references :user, index: true
      t.references :comment, index: true
      t.references :post, index: true

      t.timestamps null: false
    end
  end
end
