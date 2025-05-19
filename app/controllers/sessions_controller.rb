class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(uid: auth['uid'], provider: 'twitch') do |u|
      u.name  = auth['info']['name']
      u.email = auth['info']['email']
      # Set other attributes as needed
    end

    user.update(
      access_token: auth['credentials']['token'],
      refresh_token: auth['credentials']['refresh_token'],
      token_expires_at: Time.at(auth['credentials']['expires_at'])
    ) if auth['credentials']

    session[:user_id] = user.id
    redirect_to root_path, notice: "Logged in as #{user.name}"
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
