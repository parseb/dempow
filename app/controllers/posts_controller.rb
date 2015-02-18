class PostsController < ApplicationController


	def new

		@post = Post.new
		@post.user = current_user
	end

	def show
		@post = Post.find(params[:id])
		@user = current_user
		@comment = @post.comments.build
		@comments = Comment.where(post_id: @post.id)

		@rating = @post.ratings.build 
	end

	def create
		@user = current_user
		@post = @user.posts.build(post_params)
		
		@post.save
		redirect_to post_path(@post) 
	end

	def destroy
	@post = Post.find(params[:id])
	@post.destroy
	redirect_to :back 
	end







private

	def post_params
		params.require(:post).permit(:title, :body, :authenticity_token, :utf8)
	end


end
