require "rails_helper"

RSpec.describe MemberMailer, type: :mailer do
  describe "signup" do
    let(:mail) { MemberMailer.signup }

    it "renders the headers" do
      expect(mail.subject).to eq("Signup")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "invite" do
    let(:mail) { MemberMailer.invite }

    it "renders the headers" do
      expect(mail.subject).to eq("Invite")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
