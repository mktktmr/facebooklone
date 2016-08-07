class HomeController < ApplicationController
  def index
    @topic = Topic.new
    @topics = Topic.all.order updated_at: :DESC
  end
end
