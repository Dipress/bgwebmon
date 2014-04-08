# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AgentPaymentCurrency.create( id: 1, name: "Украинская гривня", scode: "UAH", nominal: 1, curs: 1)
AgentPaymentCurrency.create( id: 2, name: "Российский рубль", scode: "RUB", nominal: 1, curs: 3.8)
