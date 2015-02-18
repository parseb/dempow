class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :ctitle
      t.string :cbody
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
