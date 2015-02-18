class InitiativesController < ApplicationController
  
  before_action :initiative_params, only: [:create]
  before_action :terms, only: [:show]
  #before_action :istatus, only: [:show]

  def index
  	@initiatives = Initiative.all

  end

  def new
  	@user = current_user
  	@initiative = @user.initiatives.build
  end


  def create
  	@initiative = Initiative.new(initiative_params)
  	@initiative.user_id = current_user.id 
    @initiative.scope = params[:scope]

    if @initiative.scope === 'local'
      @initiative.locality = current_user.locality

    elsif @initiative.scope === 'regional'
      @initiative.county = current_user.county

    else
      @initiative.county = 'national'
      @initiative.locality = 'national'
    end
    


  	@initiative.save

  	redirect_to initiative_path(@initiative)

  end

  def show
  	@initiative = Initiative.find(params[:id])
  	@comment = @initiative.comments.build
  	@comments = Comment.all 

    @delegation = Delegation.new
    @vote = Vote.new

    @votes = Vote.all
    @delegations = Delegation.all 

    @pro = Vote.where(initiative_id: @initiative.id, vtype: 'for').count
    @against =  Vote.where(initiative_id: @initiative.id, vtype: 'against').count
    @abstain = Vote.where(initiative_id: @initiative.id, vtype: 'abstain').count 

    @uivotes = Vote.where(initiative_id: @initiative.id, user_id: current_user.id).count
    @uideleg = Delegation.where(initiative_id: @initiative.id, to: current_user.id).count

     @initiative = Initiative.find(params[:id]) 


    if @initiative.deadline < Time.now
      
        case @initiative.scope

          when 'local' && @initiative.votes.count > (User.where(locality: @initiative.user.locality).count / 2) && @pro > @against 
              @initiative.status = "Approved"

          when 'regional' && @initiative.votes.count > (User.where(locality: @initiative.user.county).count / 2) && @pro > @against
              @initiative.status = "Approved"
          
          when 'national' && @initiative.votes.count > (User.all.count / 2) && @pro > @against
              @initiative.status = "Approved"
          else 
              @initiative.status = "Deadline Passed - Unapproved"
          end              
    else
        @initiative.status = "Active"
    end

      @initiative.save 

    @scope = @initiative.scope 
    if @scope === 'local'
        @scopeid = @initiative.user.locality
    elsif @scope === 'regional'
        @scopeid = @initiative.user.county
    else
        @scopeid = 'National'
    end

    @d = []
        User.all.each do |u|
          unless u.id === current_user.id 
           @d << u  
           end 
        end
    @people = [ ]
    if params[:term]    
        @d.each do |x|             
          if x.name.include?(params[:term].to_s)
            @people.push(x)     
          end
        end
    end

    respond_to do |format|  
      format.html  
      format.json { render :json => @people.to_json }
    end
      
    

  end

  def destroy
  	@initiative = Initiative.find(params[:id])
  	@initiative.destroy
  	redirect_to initiatives_path 

  end

  def istatus
      @initiative = Initiative.find(params[:id]) 
    if @initiative.deadline < Time.now
        if @initiative.votes.count > (User.all.count / 2) && @pro > @against  
          @initiative.status = "Approved"
        else 
          @initiative.status = "Deadline Passed - Unapproved"
        end
    else
       @initiative.status = "Active"
    end
      @initiative.save 
  end


  def initiative_params
  	params.require(:initiative).permit(:title, :body, :category, :deadline, :scope)
  end

  def terms
    params.permit(:term)
  end

end
