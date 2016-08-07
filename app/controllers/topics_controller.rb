class TopicsController < ApplicationController
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

  def update
  end

  def destroy
  end

  private

  def topic_params
    params.require(:topic).permit(:content, :picture, :picture_cache)
  end
end
