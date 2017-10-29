class MessagesController < ApplicationController
  before_action :set_message, only: [:show]
  def inbox
    @messages = current_member.recieved_messages
    render :index
  end

  def sent
    @messages = current_member.sent_messages
    render :index
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save
    else
      render :new
    end
    redirect_to member_path(current_member), message:"show"
  end

  def show
    if !@message.read_at
      @message.read_at = Time.now
      @message.save
    end
  end

  private
    def set_message
      @message = Message.find_by(id: params[:id])
    end

    def message_params
      params.require(:message).permit(:subject, :body, :sender_id, :recipient_id)
    end
end
