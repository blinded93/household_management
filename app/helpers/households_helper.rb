module HouseholdsHelper
  def show_tab(tab)
    'show' if tab == selected_tab
  end
end
