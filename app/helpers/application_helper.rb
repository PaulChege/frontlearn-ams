# frozen_string_literal: true

module ApplicationHelper
  def current_class?(name)
    return 'active' if controller_name == name

    ''
  end
end
