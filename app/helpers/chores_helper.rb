module ChoresHelper
  def household_partial?
    menu_partial.include?("household")
  end
end
