class Categoria < ActiveRecord::Base
  set_table_name "categorias"
  
  attr_accessible :valor, :nombre
  
end
