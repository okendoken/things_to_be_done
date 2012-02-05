class HomeController < ApplicationController
  def index
    redirect_to user_home_path if user_signed_in?
  end
end
