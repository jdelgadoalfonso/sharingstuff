class Menu < ActiveRecord::Base
  attr_accessible :posicion, :nombre, :menu_id, :accion
  
  has_many :menus
  belongs_to :menu
end
