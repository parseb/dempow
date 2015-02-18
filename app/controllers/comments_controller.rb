class CommentsController < ApplicationController
  before_action :comment_params

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    #@post = Post.find(params[:post])
    @comment.post_id = params[:post_id]
    @comment.save
    #@comment.initiative_id = params[:initiative_id]


    redirect_to :back
  end

  def new

  end

  def comment_params
    params.require(:comment).permit(:ctitle, :cbody, :initiative_id)
  end

end
