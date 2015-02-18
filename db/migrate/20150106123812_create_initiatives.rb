class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string :title
      t.text :body
      t.references :user, index: true
      t.string :category

      t.timestamps null: false
    end
  end
end
