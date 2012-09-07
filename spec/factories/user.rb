# coding: utf-8
Factory.define :user do |u|
  	u.login			'test'
  	u.name			'Тест'
  	u.descr			'Тест'
  	u.pswd			Digest::MD5.hexdigest('test2011')
  	u.dt			Time.now
  	u.gr			0
  	u.status		0
  	u.cgr			0
  	u.pids			""
  	u.contract_pid	0
  	u.contract_cid	0
  	u.config		"last_message_id=0"	
  	u.cgr_mode		0
  	u.email			"test@mail.com"
end