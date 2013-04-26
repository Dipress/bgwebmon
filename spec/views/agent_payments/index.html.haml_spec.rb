require 'spec_helper'

describe "agent_payments/index" do
  before(:each) do
    assign(:agent_payments, [
      stub_model(AgentPayment,
        :contract => nil,
        :user => nil,
        :manager => nil,
        :value => "9.99",
        :text => "Text"
      ),
      stub_model(AgentPayment,
        :contract => nil,
        :user => nil,
        :manager => nil,
        :value => "9.99",
        :text => "Text"
      )
    ])
  end

  it "renders a list of agent_payments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
  end
end
