require "spec_helper"

describe TaskMailer do
  describe "updates" do
    let(:mail) { TaskMailer.updates }

    it "renders the headers" do
      mail.subject.should eq("Updates")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
