# coding: utf-8
Factory.define :payment do |p|
  	p.summa		20.00
  	p.comment	"За все"
  	p.dt		Time.now
  	p.lm		Time.now
end