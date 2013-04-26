require 'spec_helper'

describe "agent_payments/edit" do
  before(:each) do
    @agent_payment = assign(:agent_payment, stub_model(AgentPayment,
      :contract => nil,
      :user => nil,
      :manager => nil,
      :value => "9.99",
      :text => "MyString"
    ))
  end

  it "renders the edit agent_payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agent_payments_path(@agent_payment), :method => "post" do
      assert_select "input#agent_payment_contract", :name => "agent_payment[contract]"
      assert_select "input#agent_payment_user", :name => "agent_payment[user]"
      assert_select "input#agent_payment_manager", :name => "agent_payment[manager]"
      assert_select "input#agent_payment_value", :name => "agent_payment[value]"
      assert_select "input#agent_payment_text", :name => "agent_payment[text]"
    end
  end
end
