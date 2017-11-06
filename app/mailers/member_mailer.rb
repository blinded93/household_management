class MemberMailer < ApplicationMailer
  def signup(member)
    @member = member
    @url = new_household_member_path(current_household)

    mail to:@user.email, subject: ""
  end

  def invite(member, invitee)
    @member = member
    @invitee = invitee
    @url = household_invitees_login_url(@invitee.household)
    binding.pry
    mail to:@invitee.email, subject: "Come join the household!"
  end
end
