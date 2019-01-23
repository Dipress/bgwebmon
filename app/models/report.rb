class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  before_save :calculate

  has_many :nodes, class_name: "Node", inverse_of: :report
  accepts_nested_attributes_for :nodes, :reject_if => :all_blank, :allow_destroy => true

  attr_accessible :nodes_attributes, :rent, :channel, :electro, :other, :income, :outcome

  field :rent, type: String, default: "0.00"
  field :channel, type: String, default: "0.00"
  field :electro, type: String, default: "0.00"
  field :other, type: String, default: "0.00"
  field :income, type: String, default: "0.00"
  field :outcome, type: String, default: "0.00"


  private

    def calculate
      balance = 0
      frequence = 0
      self.nodes.each do |n|
        balance = balance + n.income.to_i
        frequence = frequence + n.frequency.to_i
      end

      outcome = self.rent.to_d + self.channel.to_i + self.electro.to_i + frequence.to_i + self.other.to_i

      self.income = format("%.2f", balance)
      self.outcome = format("%.2f", outcome)
    end
end
