class MessagesController < ApplicationController
  def index
    @recepient_id = params[:recepient_id].to_i
    @recepient = User.find @recepient_id
    @messages = Message.where('(sender_id = ? AND recepient_id = ?) OR (sender_id = ? AND recepient_id = ?)', current_user.id, @recepient_id,  @recepient_id, current_user.id).order created_at: :ASC
  end

  def create
    recepient_id = params[:message][:recepient_id]

    message = Message.new message_params
    message.sender_id = current_user.id
    message.recepient_id = recepient_id
    if message.save
      @messages = Message.where('(sender_id = ? AND recepient_id = ?) OR (sender_id = ? AND recepient_id = ?)', current_user.id, recepient_id,  recepient_id, current_user.id).order created_at: :ASC
      respond_to do |format|
        format.js { render :create }
      end
      #redirect_to "/messages/index/#{recepient_id}"
    else
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
