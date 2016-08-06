class UsersController < ApplicationController

  def index
    @page_no = params[:page_no].to_i
    users_without_mine = User.where.not id: current_user.id

    @users = users_without_mine.limit(5).offset(5 * @page_no)
    @has_pre = @page_no > 0 ? users_without_mine.limit(5).offset(5 * (@page_no - 1)).count > 0 : false
    @has_next = users_without_mine.limit(5).offset(5 * (@page_no + 1)).count > 0

    respond_to do |format|
      format.js { render :index }
    end
  end

  def message
    @page_no = params[:page_no].to_i
    each_follow_user = User.where(id: current_user.each_follow_user_ids);

    @users = each_follow_user.limit(5).offset(5 * @page_no)
    @has_pre = @page_no > 0 ? each_follow_user.limit(5).offset(5 * (@page_no - 1)).count > 0 : false
    @has_next = each_follow_user.limit(5).offset(5 * (@page_no + 1)).count > 0

    respond_to do |format|
      format.js { render :message }
    end
  end
end
