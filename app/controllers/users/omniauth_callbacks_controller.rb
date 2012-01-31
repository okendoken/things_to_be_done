class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_or_create_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    #flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    sign_in @user
    if @user.votes.empty?
      books = session["books"]
      books.each do |book|
        unless book.persisted?
          book.user = @user
          book.save
        end
        Vote.create(:book => book, :user => @user)
      end
      flash[:notice] = "Your vote counted!"
    else
      flash[:notice] = "You have already voted"
    end
    @location = '/thank_you'
  end
end