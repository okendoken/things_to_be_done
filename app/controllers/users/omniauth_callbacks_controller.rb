class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_or_create_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    #flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    sign_in @user
    flash[:notice] = "authorized FB"
    @location = '/'
  end
end