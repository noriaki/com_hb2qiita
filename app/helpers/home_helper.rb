# -*- coding: utf-8 -*-
module HomeHelper
  def header_menu_text(action_name)
    case action_name
    when 'index'
      'Home'
    when 'me'
      'Setting'
    else
      ''
    end
  end
end
