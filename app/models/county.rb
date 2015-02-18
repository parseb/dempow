class County < ActiveRecord::Base
  
  has_many :users

  has_many :localities

  scope :ordered_name, -> { order(name: :asc) }

  
end
