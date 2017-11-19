module MembersHelper
  def hide_if_logged_in
    'd-none' unless logged_in?
  end

  def field_size
    logged_in? ? 'col-9':'col pr-5 pl-5'
  end
end
