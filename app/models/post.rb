class Post < ActiveRecord::Base
belongs_to :user
has_many :comments

has_many :ratings 

validates_presence_of :title, :body



def average_rating
  		ratings.sum(:score) / (ratings.size + 0.001)
end


end
