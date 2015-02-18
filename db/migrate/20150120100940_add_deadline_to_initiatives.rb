class AddDeadlineToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :deadline, :datetime
    add_column :initiatives, :status, :string
  end
end
