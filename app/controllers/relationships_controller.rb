class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow! @user
    respond_to do |format|
      format.js { render 'create.js.erb' }
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.js { render 'destroy.js.erb' }
    end
  end
end
