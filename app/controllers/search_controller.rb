class SearchController < ApplicationController
  def index
    setLocale
    @menu_actual = 1
  end
end
