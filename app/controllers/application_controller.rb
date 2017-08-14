class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception

  def set_locale
    I18n.locale =
      extract_locale_from_subdomain ||
      extract_locale_from_params ||
      I18n.default_locale
  end

  def extract_locale_from_params
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end
