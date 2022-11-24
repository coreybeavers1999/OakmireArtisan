class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource.persisted?

      # Add to global chat
      global_chat = Chat.select(:id).where(name: 'Global').first
      UserChat.create(user_id: resource.id, chat_id: global_chat.id, created_at: Time.now, updated_at: Time.now)

      # Response
      render json: { user_id: resource.id }

    else
      render json: {
        status: { message: 'Failed to create user.', errors: resource.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end
end
