class LoginController < ApplicationController
  # Funcion index
  def index
	setLocale
    @ss = "SharingStuff"
    @menu_actual = 0
  end

  def signup
    setLocale
    @menu_actual = 0
  end
  
  def verImagen
    setLocale
    @menu_actual = 0
    @user = User.where('id' => params[:id]).first
    f = File.new(Rails.root.join('app', 'assets', 'images', 'prueba.png'), "wb")
    f.write(@user.avatar)
    f.close
  end
  
  def signup2
    setLocale
    @countries = Country.all
    @categorias = Categoria.all
    @menu_actual = 0
  end

  def terms
    setLocale
    @menu_actual = 0
  end

  def logar
  	setLocale
    @menu_actual = 0
  end

end
