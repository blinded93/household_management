# Preview all emails at http://localhost:3000/rails/mailers/member_mailer
class MemberMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/member_mailer/signup
  def signup
    MemberMailer.signup
  end

  # Preview this email at http://localhost:3000/rails/mailers/member_mailer/invite
  def invite
    MemberMailer.invite
  end

end
