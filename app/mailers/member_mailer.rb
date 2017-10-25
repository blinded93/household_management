class MemberMailer < ApplicationMailer
  def signup(member)
    @member = member
    @url = new_household_member_path(current_household)

    mail to:@user.email, subject: ""
  end

  def invite(member, invitee)
    @member = member
    @invitee = invitee
    @url = 'localhost:3000' + new_household_member_path(member.household)
    binding.pry
    mail to:@invitee.email, subject: "Come join the household!"
  end
end
