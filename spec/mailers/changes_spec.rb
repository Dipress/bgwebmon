require "spec_helper"

describe Changes do
  describe "send" do
    let(:mail) { Changes.send }

    it "renders the headers" do
      mail.subject.should eq("Send")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
