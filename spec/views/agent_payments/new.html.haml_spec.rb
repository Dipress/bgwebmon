require 'spec_helper'

describe "agent_payments/new" do
  before(:each) do
    assign(:agent_payment, stub_model(AgentPayment,
      :contract => nil,
      :user => nil,
      :manager => nil,
      :value => "9.99",
      :text => "MyString"
    ).as_new_record)
  end

  it "renders new agent_payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agent_payments_path, :method => "post" do
      assert_select "input#agent_payment_contract", :name => "agent_payment[contract]"
      assert_select "input#agent_payment_user", :name => "agent_payment[user]"
      assert_select "input#agent_payment_manager", :name => "agent_payment[manager]"
      assert_select "input#agent_payment_value", :name => "agent_payment[value]"
      assert_select "input#agent_payment_text", :name => "agent_payment[text]"
    end
  end
end
