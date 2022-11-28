class MessagesController < ApiController
  def create_message
    # Build message out
    message = Message.new
    message.chat_id = params[:chat_id]
    message.user_id = params[:user_id]
    message.text = params[:text]

    # Save message
    unless message.save
      render json: { message: 'Failed to send message' }, status: :unprocessable_entity
    end
  end

  def get_messages
    # Get list of messages
    raw_message_list = Message.select(:text, :user_id).where(chat_id: params[:chat_id])
    message_list = []

    # Clean up list
    raw_message_list.each do |m|
      # Get user who sent message
      from_user = User.find(m.user_id)

      # Format list
      message_list.push({
                          username: from_user.username,
                          text: m.text
                        })
    end

    # Send payload
    render json: { messages: message_list }
  end
end