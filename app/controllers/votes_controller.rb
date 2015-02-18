class VotesController < ApplicationController
	before_action :vote_params

	def create
		@vote = Vote.new(vote_params)

		@vote.user_id = current_user.id
		@vote.vtype = params[:vote][:vtype]
		@vote.initiative_id = params[:initiative_id]
		
		d = Delegation.where(initiative_id: @vote.initiative_id, to: current_user.id).count
		vnr = Vote.where(initiative_id: params[:initiative_id], user_id: current_user.id).count

		if Vote.where(initiative_id: params[:initiative_id], user_id: current_user.id).count === 0		

			if d != 0
				d.times do
					Vote.create(user_id: current_user.id, vtype: params[:vote][:vtype], initiative_id: params[:initiative_id])
				end
			end	

			@vote.save 
			
		else

			revisedd = d - (vnr - 1)

			revisedd.times do
				Vote.create(user_id: current_user.id, vtype: params[:vote][:vtype], initiative_id: params[:initiative_id])
			end
		end

		redirect_to :back, :notice => "Thank you for voting!"
	end


	private 

	def vote_params
		params.require(:vote).permit(:vtype, :user_id, :initiative_id)
		
	end

end
