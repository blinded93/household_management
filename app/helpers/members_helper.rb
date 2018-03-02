module MembersHelper
  def hide_unless_logged_in
    'd-none' unless logged_in?
  end

  def field_size
    logged_in? ? 'col-8':'col pr-5 pl-5'
  end

  def label_size
    logged_in? ? 'col-4': ''
  end

  def update_collapse(collapse)
    if collapse
      "collapse show"
    else
      "collapse"
    end
  end
end
