class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :posts 
has_many :comments 
has_many :initiatives

#belongs_to :locality
#belongs_to :county 




has_many :votes


#follow#####

has_many :active_relationships, class_name: 'Relationship',
								foreign_key: 'follower_id',
								dependent: :destroy

has_many :passive_relationships, class_name: 'Relationship',
								 foreign_key: 'followed_id',
								 dependent: :destroy

has_many :following, through: :active_relationships, source: :followed

has_many :followers, through: :passive_relationships, source: :follower

has_many :followeds, through: :active_relationships, source: :followed

def follow(other_user)
	active_relationships.create(followed_id: other_user.id)
end

def unfollow(other_user)
	active_relationships.find_by(followed_id: other_user.id).destroy
end

def following?(other_user)
	following.include?(other_user)
end


##################################
#def feed

	#following_ids = "SELECT followed_id FROM relationships
    #                 WHERE  follower_id = :user_id"
	#Post.all.where("user_id IN (:following_ids) OR user_id = :user_id",
    #                following_ids: following_ids, user_id: id)
	#Initiative.all.where("user_id IN (:following_ids) OR user_id = :user_id",
    #               following_ids: following_ids, user_id: id)
#end
##############

# seems_rateable_rater



has_attached_file :avatar, :styles => {:medium => "450x450#", :thumb => "100X100#"}, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/



end
