require 'spec_helper'

describe "agent_payments/show" do
  before(:each) do
    @agent_payment = assign(:agent_payment, stub_model(AgentPayment,
      :contract => nil,
      :user => nil,
      :manager => nil,
      :value => "9.99",
      :text => "Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/9.99/)
    rendered.should match(/Text/)
  end
end
