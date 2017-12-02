module HouseholdsHelper
  def show_tab(tab)
    'show' if tab == selected_tab
  end

  def show_scope(scope)
    'show' if scope == selected_scope
  end

  def house_redirect(tab, scope)
    hash = {tab:tab}
    hash[:scope] = scope if scope
    household_control_path(current_household, hash)
  end
end
