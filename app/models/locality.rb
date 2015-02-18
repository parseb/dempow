class Locality < ActiveRecord::Base
  
  #scope :ordered_name, -> { order(name: :asc) }

  default_scope { order('name ASC') } 

  belongs_to :county

  has_many :users
   
end
