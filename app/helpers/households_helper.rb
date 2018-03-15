module HouseholdsHelper
  def household_destroy_btn
    content_tag :small do
      link_to "Remove Household",
        [current_household],
        method:'delete',
        class:'text-danger small justify-right',
        data:{
          confirm:"<div class='text-center h5 pt-3'>This action will remove your household account and all of its members from our database.<br>Continue?</div>",
          commit:"Delete Household",
          cancel:"Cancel"
        }
    end
  end
end
