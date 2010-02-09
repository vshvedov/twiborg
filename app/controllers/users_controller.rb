class UsersController < ApplicationController

  before_filter :login_required, :only => [ :profile ]

  def registration
    authorize(finalize_registration_url)
  end

  def finalize_registration
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])
    session['rtoken']  = nil
    session['rsecret'] = nil
    profile = Twitter::Base.new(oauth).verify_credentials

    token = User.new_signature
    cookies[:st] = {
      :value   => token,
      :expires => 1.year.from_now
    }
    user = User.new(
      :name => profile.screen_name, 
      :atoken => oauth.access_token.token, 
      :asecret => oauth.access_token.secret, 
      :remember_token => token, 
      :twitter_uid => profile.id, 
      :avatar_url => profile.profile_image_url)
    if user.save
      notice('Registered')
    else
      error('Can`t register')
      user.errors.each{|e| error('<br />'+e.join(" "))}
    end
    redirect_to root_path
  end

  def login
    authorize(finalize_login_url)
  end

  def finalize_login
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])
    session['rtoken']  = nil
    session['rsecret'] = nil
    profile = Twitter::Base.new(oauth).verify_credentials
    user = User.first(:conditions => {:atoken => oauth.access_token.token, :asecret => oauth.access_token.secret})
    if user
      login_user(user)
      current_user.cdebug :current
      notice('Logged in')
    else
      error('Can`t login')
    end
    redirect_to root_path
  end

  def logout
    logout_killing_session!
    redirect_to root_path
  end

  def profile
    @user = current_user
  end

private

  def authorize url
    oauth.set_callback_url(url)
    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    redirect_to oauth.request_token.authorize_url
  end
end
