class MemberMailerPreview < ActionMailer::Preview
  def invite
    MemberMailer.invite(User.first, Invitee.first)
  end
end
