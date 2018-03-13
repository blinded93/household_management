module HouseholdsHelper
  def menu_link(link_name)
    link_to link_name,
      "##{link_name.downcase}",
      class:"btn btn-sm btn-outline-secondary text-dark",
      data:{
        parent:"#admin-control",
        toggle:"collapse"
      },
      aria:{
        expanded:"false",
        controls:"#{link_name.downcase}"
      }
  end
end
