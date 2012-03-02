class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    #flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    sign_in @user
  end

  def twitter
    access_token = request.env["omniauth.auth"]
    if @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
      sign_in @user
      render 'close'
    else
      session['twitter_data'] = { :uid => access_token['uid'], :token => access_token['credentials']['token'],
                                  :secret => access_token['credentials']['secret'], :name => access_token.info.name,
                                  :provider => 'twitter', :link => access_token.info.urls['Twitter'] }
    end
  end

  def twitter_email
    email = request[:email]
    unless session['twitter_data'].nil?
      @user = User.create!(:email => email, :password => Devise.friendly_token[0,20],
                           :nickname => session['twitter_data'].name)
      auth = @user.authorizations.build(session['twitter_data'])
      @user.authorizations << auth
      sign_in @user
      render 'close'
    end
  end

  def failure
    #I've found it!!!!
    #see view
  end

  def vkontakte
    access_token = request.env["omniauth.auth"]
    if @user = User.find_for_vkontakte_oauth(access_token, current_user)
      sign_in @user
      render 'close'
    else
      session['vkontakte_data'] = { :uid => access_token['uid'], :token => access_token['credentials']['token'],
                                    :secret => nil, :name => access_token.info.name,
                                    :provider => 'vkontakte', :link => access_token.info.urls['Vkontakte'] }
    end
  end

  def vkontakte_email
    email = request[:email]
    unless session['vkontakte_data'].nil?
      @user = User.create!(:email => email, :password => Devise.friendly_token[0,20],
                           :nickname => session['vkontakte_data'].name)
      auth = @user.authorizations.build(session['vkontakte_data'])
      @user.authorizations << auth
      sign_in @user
      render 'close'
    end
  end
end