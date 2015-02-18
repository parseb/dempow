class UsersController < ApplicationController

  before_action :authenticate_user!
   

  def index
    redirect_to user_path(current_user)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
    @initiatives = Initiative.all 

     @items = []
     @feed_items = []

     Post.all.each do |p|

    if @user.following?(User.find(p.user_id))
        @items << p 
      end
    end

    @initiatives.each do |i|
      if @user.following?(User.find(i.user_id))
        @items << i 
      end
    end

    #@feed_items = @items.where(:created_at > @user.created_at)
    
    @items.each do |ii| 
      if ii.created_at > @user.created_at
        @feed_items << ii 
      end
    end



  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'following'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'followers'
  end





end