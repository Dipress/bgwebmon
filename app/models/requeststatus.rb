# coding: utf-8
class Requeststatus < ActiveRecord::Base
  belongs_to :requestfl
  attr_accessible :title
end
