class DelegationsController < ApplicationController

	before_action :delegation_params, only: [:create]


	def create
		@delegation = Delegation.new(delegation_params)
		@delegation.user_id = current_user.id
		@delegation.to = params[:to][:id]
		@delegation.initiative_id = params[:initiative_id]

		@delegation.value = 1 
		
		@delegation.save

		redirect_to :back 
	end


private

	def delegation_params
		params.permit(:id, :user_id, :initiative_id, :to, :value)
	end

end
