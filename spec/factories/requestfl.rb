# coding: utf-8
Factory.define :requestfl do |c|
	c.description			"Описание"
	c.fio					"Тестов Тест Тестович"
	c.adress_post			"Украниа, АР Крым, Симферополь, ул. Тургенева, 20"
	c.adress_connection		"Украниа, АР Крым, Симферополь, ул. Тургенева, 20"
	c.latlng_connection		"2.234,2.3534"
	c.email					"roma@crimeainfo.com"
	c.telephone				"+380501234567"
	c.in					"23235235"
	c.pasport				"ET 123456"
	c.pasport_authority		"Киевски ГУГУ Симферопольского МВД в АР Крым"
	c.pd					"10.10.2012"
	c.ip					"172.28.200.3"
	c.login					"test"
	c.password				"test_pass"
	c.technology			1
	c.node					1
	c.payment_form			1
end