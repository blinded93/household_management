module HouseholdsHelper
  def household_partial?
    menu_partial.include?("household")
  end

  def show_tab(tab)
    'show' if tab == selected_tab
  end
end
