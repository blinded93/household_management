class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy]

  def new
    @message = Message.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.js {
          render "create",
          locals:{obj:@message}
        }
      else
        format.js {
          render "errors",
          locals:{
            obj:@message,
            message_id:nil
          }
        }
      end
    end
  end

  def show
    @reply_message = Message.new
    @message.read_at = Time.now
    @message.save
    @reply_id = params[:reply_message_id]
    respond_to do |format|
      format.js {
        render 'new',
        locals:{message:@message}
      }
    end
  end

  def reply
    @message = Message.new(reply_params)
    respond_to do |format|
      if @message.save
        format.js {
          render 'create',
          locals:{obj:@message}
        }
      else
        format.js {
          render "errors",
          locals:{
            obj:@message,
            message_id:params[:reply_message_id]
          }
        }
      end
    end
  end

  def check
    respond_to do |format|
      format.js { render 'check_messages' }
    end
  end

  def destroy
    respond_to do |format|
      @message.destroy
      format.js {
        render 'shared/delete',
        locals:{obj:@message}
      }
    end
  end

  private
    def set_message
      @message = Message.find_by(id:params[:id])
    end

    def reply_params
      params.require(:message).permit(:subject, :body, :sender_id, :recipient_id, :reply_message_id)
    end

    def message_params
      params.require(:message).permit(:subject, :body, :sender_id, :recipient_id)
    end
end
