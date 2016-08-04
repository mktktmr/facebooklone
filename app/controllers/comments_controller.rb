class CommentsController < ApplicationController
  
  def create
    comment = Comment.new comment_params
    comment.topic_id = params[:topic_id]
    if comment.save
      redirect_to root_path
    else
      render 'home/index'
    end

  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
