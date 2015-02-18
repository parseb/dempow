class RatingsController < ApplicationController

before_action :rating_params

def create
	@rating = Rating.create(rating_params)

	@rating.user_id = current_user.id 
	@rating.post_id = params[:post_id]
	@rating.value = params[:value][:value]
  
	@rating.save

	redirect_to :back 
end


private

def rating_params
	params.permit(:value, :post_id, :user_id, :comment_id)
end


end
