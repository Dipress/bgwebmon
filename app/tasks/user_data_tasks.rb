# coding: utf-8
require 'axlsx'

class UserDataTasks

	def self.generation_urlica

		#entities
		contracts = Contract.where(pgid: 2)

		title = [
			"№ договора",
			"Наименование организации",
			"Логин",
			"IP-адрес",
			"ИНН",
			"Адрес (почтовый)",
			"Адрес (юридический)",
			"Адрес (подключения)",
			"Тип подключения",
			"Точка подключения",
			"Дата подключения",
			"Дата отключения",
			"Контактный телефон",
			"Email"
		]

		Axlsx::Package.new do |p|
			p.workbook.add_worksheet(name: "Юридические лица") do |sheet1|
				sheet1.add_row(title)
				contracts.each do |c|
					if c.phones.where(pid: 14).present? && c.russian_mobile.present?
						sheet1.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,"#{c.date1}","#{c.date2}",nil, nil]
					elsif c.russian_mobile.nil? && c.phones.where(pid: 14).present?
						c.phones.where(pid: 14).each do |phone|
							sheet1.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,"#{c.date1}","c.date2","#{phone.value}", nil]
						end
					else
						sheet1.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,"#{c.date1}","#{c.date2}","#{c.russian_mobile}", nil]
					end
				end
			end

			p.workbook.add_worksheet(name: "Логины") do |sheet2|
				sheet2.add_row(title)

				contracts.each do |c|
					if c.inet_services.empty?
						sheet2.add_row ["#{c.title}",nil,nil]
					else
						c.inet_services.each do |inet|
							sheet2.add_row ["#{c.title}", nil,"#{inet.login}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Наименование организации") do |sheet3|
				sheet3.add_row(title)
				contracts.each do |c|
					c.contract_parameter_type1.where(pid: 2).each do |organization|
						sheet3.add_row ["#{c.title}","#{organization.val}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
					end
				end
			end

			p.workbook.add_worksheet(name: "ИНН") do |sheet4|
				sheet4.add_row(title)
				contracts.each do |c|
					if c.contract_parameter_type1.where(pid: 61).empty?
						sheet4.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
					else
						c.contract_parameter_type1.where(pid: 61).each do |inn|
							sheet4.add_row ["#{c.title}",nil, nil,nil,"#{inn.val}",nil,nil,nil,nil,nil,nil,nil,nil,nil]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "IP-адрес и маска") do |sheet5|
				sheet5.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type1.where(pid: 34).empty?
						sheet5.add_row ["#{c.title}",nil, nil, nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
					else
						c.contract_parameter_type1.where(pid: 34).each do |ip|
							sheet5.add_row ["#{c.title}",nil, nil, "#{ip.val}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Адрес (почтовый") do |sheet6|
				sheet6.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type2.where(pid:5).empty?
						sheet6.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
					else
						c.contract_parameter_type2.where(pid:5).map do |post_address|
							sheet6.add_row ["#{c.title}",nil,nil,nil, nil,"#{post_address.address}",nil,nil,nil,nil,nil,nil,nil,nil]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Адрес (юридический)") do |sheet7|
				sheet7.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type2.where(pid:6).empty?
						sheet7.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
					else
						c.contract_parameter_type2.where(pid:6).map do |post_address|
							sheet7.add_row ["#{c.title}",nil,nil,nil, nil,nil, "#{post_address.address}",nil,nil,nil,nil,nil,nil,nil]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Адрес (подключения)") do |sheet8|
				sheet8.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type2.where(pid:42).empty?
						sheet8.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
					else
						c.contract_parameter_type2.where(pid:42).map do |post_address|
							sheet8.add_row ["#{c.title}",nil,nil,nil, nil,nil,nil, "#{post_address.address}",nil,nil,nil,nil,nil,nil]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Технология передачи данных") do |sheet9|
				sheet9.add_row(title)
				contracts.each do |c|
					if c.contract_parameter_type7.where(pid:53).empty?
						sheet9.add_row ["#{c.title}",nil]
					else
						c.contract_parameter_type7.where(pid:53).each do |data_type|
							if data_type.val.eql?(-1) || data_type.val.eql?(0)
								sheet9.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
							else
								cpt7v = ContractParameterType7Value.find(data_type.val)
								sheet9.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,"#{cpt7v.title}",nil,nil,nil,nil,nil]
							end
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Точка подключения") do |sheet10|
				sheet10.add_row(title)
				contracts.each do |c|
					if c.contract_parameter_type7.where(pid:54).empty?
						sheet10.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
					else
						c.contract_parameter_type7.where(pid:54).each do |data_type|
							if data_type.val.eql?(-1) || data_type.val.eql?(0)
								sheet10.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
							else
								cpt7v = ContractParameterType7Value.find(data_type.val)
								sheet10.add_row ["#{c.title}",nil,nil,nil,nil,nil,nil,nil,nil,"#{cpt7v.title}",nil,nil,nil,nil]
							end
						end
					end
				end
			end


			p.serialize('big_brother_data_urlica.xsl')
		end

	end

	def generation_fizlica
		

		#individuals
		contracts = Contract.where(pgid: 1)

		title = [
			"№ Договора", 
			"Ф.И.О.","Логин",
			"IP-адрес/маска",
			"Паспорт",
			"Дата выдачи паспорта",
			"Кем выдан паспорт",
			"Дата рождения",
			"Адрес (почтовый)",
			"Адрес (подключения)",
			"Тип подключения", 
			"Точка подключения", 
			"Дата подключения", 
			"Дата отключения",
			"Телефон"
		]

		Axlsx::Package.new do |p|
			p.workbook.add_worksheet(name: "Физические лица") do |sheet1|
				sheet1.add_row(title)

				contracts.each do |c|
					if c.russian_mobile.nil? && c.contract_parameter_type1.where(pid:24).empty?
						sheet1.add_row ["#{c.title}", "#{c.comment}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,"#{c.date1}","#{c.date2}", nil]
					else
						sheet1.add_row ["#{c.title}", "#{c.comment}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,"#{c.date1}","#{c.date2}","#{c.russian_mobile}"]
					end
				end
			end

			p.workbook.add_worksheet(name: "Логины") do |sheet2|
				sheet2.add_row(title)

				contracts.each do |c|
					if c.inet_services.empty?
						sheet2.add_row ["#{c.title}", "#{c.comment}",nil]
					else
						c.inet_services.each do |inet|
							sheet2.add_row ["#{c.title}", "#{c.comment}","#{inet.login}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "IP-адрес и маска") do |sheet4|
				sheet4.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type1.where(pid: 34).empty?
						sheet4.add_row ["#{c.title}","#{c.comment}", nil, nil]

					else
						c.contract_parameter_type1.where(pid: 34).each do |ip|
							sheet4.add_row ["#{c.title}","#{c.comment}", nil, "#{ip.val}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Паспорт") do |sheet5|
				sheet5.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type1.where(pid:24).empty?
						sheet5.add_row ["#{c.title}","#{c.comment}",nil ,nil, nil]
					else
						c.contract_parameter_type1.where(pid:24).map do |passport|
							sheet5.add_row ["#{c.title}","#{c.comment}",nil, nil, "#{passport.val}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Дата выдачи паспорта") do |sheet6|
				sheet6.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type6.where(pid:27).empty?
						sheet6.add_row ["#{c.title}","#{c.comment}",nil,nil,nil, nil]
					else
						c.contract_parameter_type6.where(pid:27).map do |passport_date|
							sheet6.add_row ["#{c.title}","#{c.comment}",nil,nil,nil, "#{passport_date.val}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Кем выдан паспорт") do |sheet7|
				sheet7.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type1.where(pid:25).empty?
						sheet7.add_row ["#{c.title}","#{c.comment}",nil,nil,nil, nil,nil]
					else
						c.contract_parameter_type1.where(pid:25).map do |passport_service|
							sheet7.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil, "#{passport_service.val}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Дата рождения") do |sheet8|
				sheet8.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type6.where(pid:58).empty?
						sheet8.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil, nil, nil]
					else
						c.contract_parameter_type6.where(pid:58).map do |borning_date|
							sheet8.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil,nil, "#{borning_date.val}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Адрес почтовый") do |sheet9|
				sheet9.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type2.where(pid:5).empty?
						sheet9.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil, nil, nil, nil]
					else
						c.contract_parameter_type2.where(pid:5).map do |post_address|
							sheet9.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil,nil,nil, "#{post_address.address}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Адрес подключения") do |sheet10|
				sheet10.add_row(title)

				contracts.each do |c|
					if c.contract_parameter_type2.where(pid:42).empty?
						sheet10.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil, nil,nil, nil, nil]
					else
						c.contract_parameter_type2.where(pid:42).map do |connect_address|
							sheet10.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil,nil,nil, nil, "#{connect_address.address}"]
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Технология передачи данных") do |sheet11|
				sheet11.add_row(title)
				contracts.each do |c|
					if c.contract_parameter_type7.where(pid:53).empty?
						sheet11.add_row ["#{c.title}","#{c.comment}"]
					else
						c.contract_parameter_type7.where(pid:53).each do |data_type|
							if data_type.val.eql?(-1) || data_type.val.eql?(0)
								sheet11.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil,nil,nil,nil,nil, nil]
							else
								cpt7v = ContractParameterType7Value.find(data_type.val)
								sheet11.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil,nil,nil,nil,nil,"#{cpt7v.title}"]
							end
						end
					end
				end
			end

			p.workbook.add_worksheet(name: "Точка подключения") do |sheet12|
				sheet12.add_row(title)
				contracts.each do |c|
					if c.contract_parameter_type7.where(pid:54).empty?
						sheet12.add_row ["#{c.title}","#{c.comment}"]
					else
						c.contract_parameter_type7.where(pid:54).each do |data_type|
							if data_type.val.eql?(-1) || data_type.val.eql?(0)
								sheet12.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
							else
								cpt7v = ContractParameterType7Value.find(data_type.val)
								sheet12.add_row ["#{c.title}","#{c.comment}",nil,nil,nil,nil,nil,nil,nil,nil,nil,"#{cpt7v.title}"]
							end
						end
					end
				end
			end
			p.serialize('big_brother_data_fizlica.xsl')
		end

	end
end