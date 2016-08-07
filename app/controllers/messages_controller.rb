class MessagesController < ApplicationController

  def index
    @message = Message.new
    @recepient_id = params[:recepient_id].to_i
    @recepient = User.find @recepient_id
    @messages = Message.where('(sender_id = ? AND recepient_id = ?) OR (sender_id = ? AND recepient_id = ?)', current_user.id, @recepient_id,  @recepient_id, current_user.id).order created_at: :ASC
  end

  def create
    @recepient_id = params[:message][:recepient_id]

    @message = Message.new message_params
    @message.sender_id = current_user.id
    @message.recepient_id = @recepient_id

    @messages = Message.where('(sender_id = ? AND recepient_id = ?) OR (sender_id = ? AND recepient_id = ?)', current_user.id, @recepient_id,  @recepient_id, current_user.id).order created_at: :ASC

    if @message.save
      respond_to do |format|
        format.js { render :create }
      end
    else
      @recepient = User.find @recepient_id
      respond_to do |format|
        format.js { render partial: 'error' }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
