class MessagesController < ApplicationController
  def inbox
    @messages = current_member.recieved_messages
  end

  def sent
    @messages = current_member.sent_messages
  end

  def show
  end
end
