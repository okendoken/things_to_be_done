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

  def after_sign_in_path_for(resource_or_scope)
    user_home_path
  end

  def is_current_user?(user)
    is_current_user_id?(user.id)
  end

  def is_current_user_id?(id)
    user_signed_in? and id == current_user.id
  end
end
