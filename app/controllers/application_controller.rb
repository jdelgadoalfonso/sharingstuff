require "assets/numeric.rb"

class ApplicationController < ActionController::Base
  protect_from_forgery
  def initialize
    super()
    @menu = Menu.order('posicion').where(:menu_id => nil)
    @available = %w{en es}
  end
  
  def setLocale
    params[:locale] = request.preferred_language_from(@available)
    if params[:locale]
      I18n.locale = params[:locale]
    else
      I18n.locale = "en"
    end
  end

end
