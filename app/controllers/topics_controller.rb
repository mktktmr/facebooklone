class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id

    if @topic.save
      redirect_to root_path
    else
      @topics = Topic.all
      render 'home/index'
    end
  end

  def edit
    respond_to do |format|
      format.js { render partial: 'edit' }
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to root_path
    else
      respond_to do |format|
        format.js { render partial: 'error' }
      end
    end
  end

  def destroy
    @topic.destroy
    redirect_to root_path, notice: '正常に削除されました。'
  end

  private

  def topic_params
    params.require(:topic).permit(:content, :picture, :picture_cache)
  end

  def set_topic
    @topic = Topic.find params[:id]
  end
end
