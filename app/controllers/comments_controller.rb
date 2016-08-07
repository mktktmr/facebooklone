class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  
  def create
    @comment = Comment.new comment_params
    @comment.topic_id = params[:topic_id]
    if @comment.save
      respond_to do |format|
        format.js { render :create }
      end
    else
      respond_to do |format|
        format.js { render partial: 'error' }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render partial: 'edit' }
    end
  end

  def update
    if @comment.update(comment_params)
      @topic = @comment.topic
      respond_to do |format|
        format.js { render 'update' }
      end
    else
      respond_to do |format|
        format.js { render partial: 'modal_error' }
      end
    end
  end

  def destroy
    @topic = @comment.topic
    @comment.destroy
    respond_to do |format|
      format.js { render 'destroy' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
