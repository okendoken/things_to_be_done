class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end


  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.empty? ? 'pirate' : request.subdomains.first
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  end

  private

  #there are many paths available e.g. after_sign_up_path_for, after_sign_out_path_for etc
  #def after_sign_in_path_for(resource_or_scope)
  #  #crappy code because of L:13
  #  #if sign up then to user#show else user#edit
  #  current_user.sign_in_count <= 1 ? new_user_path : current_user
  #end
  #
  ##doesn't work!!!
  #def after_sign_up_path_for(resource_or_scope)
  #  new_user_path
  #end

  #code to allow login from wherever
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
