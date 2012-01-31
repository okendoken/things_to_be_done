class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else
      # Create a user with a stub password.
      #todo i can get more user info here. not just email
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_or_create_for_facebook_oauth(access_token, signed_in_resource=nil)
    new_user = find_for_facebook_oauth(access_token, signed_in_resource)
    new_user.save unless new_user.persisted?
    new_user
  end

  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"]
        end
      end
    end
end
