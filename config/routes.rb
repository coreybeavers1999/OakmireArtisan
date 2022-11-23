Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/member_details' => 'members#index'

  # User
  patch 'users/update_username' => 'users#update_username'

  # Messaging
  post 'send_message' => 'messages#create_message'
  get 'get_messages' => 'messages#get_messages'

end
