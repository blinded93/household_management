module HouseholdsHelper
  def show_tab(tab)
    'show' if tab == selected_tab
  end

  def show_scope(scope)
    'show' if scope == selected_scope
  end
end
