class UsersController < ApiController

  def update_username
    # Make sure username is unique
    search = User.where('lower(username) = ?', params[:username].downcase).first
    taken = search.present?

    if taken
      render json: { message: 'Username taken. Sorry.' }, status: :unprocessable_entity
      return
    end

    # Get user and set username
    user = current_user
    user.username = params[:username]

    # Save
    if user.save
      render json: { message: 'Username saved!', user: current_user }
    else
      render json: { message: 'Username was unable to be saved.' }
    end

  end
end