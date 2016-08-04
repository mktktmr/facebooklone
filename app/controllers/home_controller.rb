class HomeController < ApplicationController
  def index
    @topics = Topic.all.order(updated_at: :desc)
  end
end
