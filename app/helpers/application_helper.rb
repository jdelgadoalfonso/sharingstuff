module ApplicationHelper
  
  ASSETS = 'app/assets'
  
  def controller_stylesheet_link_tag 
    stylesheet = "#{params[:controller]}.css.scss"
    
    stylesheet_link_tag stylesheet unless
      !File.exists?(File.join(Rails.root, ASSETS, 'stylesheets', stylesheet))
  end
  
  def action_stylesheet_link_tag 
    stylesheet = "#{params[:action]}.css.scss"
    
    stylesheet_link_tag stylesheet unless
      !File.exists?(File.join(Rails.root, ASSETS, 'stylesheets', stylesheet))
  end
  
  def controller_javascript_include_tag 
    javascript = "#{params[:controller]}.js.coffee"
    
    javascript_include_tag javascript unless
      !File.exists?(File.join(Rails.root, ASSETS, 'javascripts', javascript))
  end
  
  def action_javascript_include_tag 
    javascript = "#{params[:action]}.js.coffee"
    
    javascript_include_tag javascript unless
      !File.exists?(File.join(Rails.root, ASSETS, 'javascripts', javascript))
  end
  
  def draw_navigator(menu, menu_actual)
    html = ""
    menu.each do |item|
      html << "<li#{menu_actual.truncate_to(item.posicion.numdec) == item.posicion ? " class=current-menu-item" : ""} >\n"
      html << "<a href=#{item.accion}>#{t item.nombre}</a>\n"
      if item.menus != nil and item.menus.length > 0
        html << "<ul>\n"
        html << draw_navigator(item.menus, menu_actual)
        html << "</ul>\n"
      end
      html << "</li>\n"
    end
    html.html_safe
  end
  
end
