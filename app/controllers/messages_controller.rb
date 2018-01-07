class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy]

  def inbox
    @messages = current_member.recieved_messages
    render :index
  end

  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.js { render "create",
                    locals:{obj:@message}
                  }
      else
        format.js { render "errors",
                    locals:{obj:@message,
                            message_id:nil}
                  }
      end
    end
  end

  def reply
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.js { render 'create',
                    locals:{obj:@message}
                  }
      else
        format.js { render "errors",
                    locals:{obj:@message,
                            message_id:params[:reply_message_id]}
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
    @message.destroy
    redirect_to member_path(current_member)
  end

  private
    def set_message
      @message = Message.find_by(id: params[:id])
    end

    def message_params
      params.require(:message).permit(:subject, :body, :sender_id, :recipient_id, :reply_message_id)
    end
end
