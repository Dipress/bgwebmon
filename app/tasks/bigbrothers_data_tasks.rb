# coding: utf-8
require 'csv'

class BigbrothersDataTasks
  
  def self.create_data
    t = Time.new
    csv_file = "#{t.year}-#{t.month}-#{t.day}-#{t.hour}-#{t.min}.csv"

    contract = Contract.where(fc: 0, pgid: 1).where(status: [0,2,4])

    CSV.open(csv_file, "wb", encoding: "utf-8") do |csv|
      csv << [
        'PHONE',
        'ABONENT', 
        'ABONENT_I', 
        'ABONENT_O',
        'ABONENT_F', 
        'BIRTH_DAY', 
        'DOCUMENT_TYPE',
        'DOCUMENT_SERIES', 
        'DOCUMENT_NUMBER', 
        'DOCUMENT_DATE', 
        'DOCUMENT_UNIT', 
        'DOCUMENT_UNIT_ID',
        'ADDR_INDEX',
        'ADDR_COUNTRY',
        'ADDR_CITY',
        'ADDR_STREET',
        'ADDR_HOUSE',
        'ADDR_ROOM',
        'CONTR_DATE',
        'CONTR_NUM',
        'CONTR_END',
        'STATUS',
        'ACT_DATE'
      ]
      contract.each do |c|
        begin
          csv << [ "#{ c.contract_parameter_type1.where(pid: 74).map { |cp1| cp1.val }.first }", # PHONE
                   "#{ c.contract_parameter_type1.where(pid: 29).map { |cp1| cp1.val }.first }", # ABONENT
                   "#{ c.contract_parameter_type1.where(pid: 29).map { |cp1| cp1.val }.first.to_s.split(" ")[1] }", # ABONENT_I
                   "#{ c.contract_parameter_type1.where(pid: 29).map { |cp1| cp1.val }.first.to_s.split(" ")[2] }", # ABONENT_O
                   "#{ c.contract_parameter_type1.where(pid: 29).map { |cp1| cp1.val }.first.to_s.split(" ")[0] }", # ABONENT_F 
                   "#{ c.contract_parameter_type6.where(pid: 58).map { |cp6| cp6.val }.first }", # BIRTH_DAY
                   "#{ c.contract_parameter_type7.where(pid: 80).map { |cp7| ContractParameterType7Value.find(cp7.val).title }.first.to_s }", # DOCUMENT_TYPE
                   "#{ c.contract_parameter_type1.where(pid: 76).map { |cp1| cp1.val }.first }", # DOCUMENT_SERIES
                   "#{ c.contract_parameter_type1.where(pid: 77).map { |cp1| cp1.val }.first }", # DOCUMENT_NUMBER
                   "#{ c.contract_parameter_type6.where(pid: 27).map { |cp6| cp6.val }.first }", # DOCUMENT_DATE
                   "#{ c.contract_parameter_type1.where(pid: 25).map { |cp1| cp1.val }.first }", # DOCUMENT_UNIT
                   "#{ c.contract_parameter_type1.where(pid: 78).map { |cp1| cp1.val }.first }", # DOCUMENT UNIT_ID
                   "", # ADDR_INDEX
                   "", # ADDR_COUNTRY
                   "", # ADD_CITY
                   "", # ADDR_STREET
                   "#{ c.contract_parameter_type2.where(pid: 42).first.address_house.house }", # ADDR_HOUSE
                   "", # ADDR_ROOM
                   "#{ c.date1 }",
                   "#{ c.title }",
                   "#{ c.date2 }",
                   "#{ c.status }",
                   "#{ c.date1 }"
                  ]
        rescue Exception => e
          puts e
        end
      end
    end
  end
end



SELECT 
( SELECT val FROM contract_parameter_type_1 WHERE pid = 29 AND contract_parameter_type_1.cid = contract.id ) as ABONENT,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 74 AND contract_parameter_type_1.cid = contract.id ) as PHONE,
( SELECT val FROM contract_parameter_type_6 WHERE pid = 58 AND contract_parameter_type_6.cid = contract.id ) as BIRTH_DAY,
( SELECT title FROM contract_parameter_type_7_values 
  LEFT JOIN contract_parameter_type_7 ON contract_parameter_type_7_values.id = contract_parameter_type_7.val 
  WHERE contract_parameter_type_7.pid = 80 AND contract_parameter_type_7.cid = contract.id ) as DOCUMENT_TYPE,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 76 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_SERIES,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 77 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_NUMBER,
( SELECT val FROM contract_parameter_type_6 WHERE pid = 27 AND contract_parameter_type_6.cid = contract.id ) as DOCUMENT_DATE,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 25 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_UNIT,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 78 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_UNIT_ID,
( SELECT house FROM address_house
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id
) as ADDR_HOUSE,
( SELECT address_street.title FROM address_street
  LEFT JOIN address_house ON address_street.id = address_house.streetid
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id
) as ADDR_STREET,
( SELECT address_city.title FROM address_city
  LEFT JOIN address_street ON address_city.id = address_street.cityid
  LEFT JOIN address_house ON address_street.id = address_house.streetid
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id 
) as ADDR_CITY,
( SELECT address_country.title FROM address_country
  LEFT JOIN address_city ON address_city.country_id = address_country.id
  LEFT JOIN address_street ON address_city.id = address_street.cityid
  LEFT JOIN address_house ON address_street.id = address_house.streetid
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id 
) as ADDR_COUNTRY,
contract.date1 as CONTR_DATE,
contract.title as CONTR_NUM,
contract.date2 as CONTR_END,
contract.status as STATUS,
contract.date1 as ACT_DATE
FROM
contract
WHERE contract.fc = 0 AND contract.pgid = 1 AND contract.status IN (0, 2, 4)
ORDER BY contract.title LIMIT 50;





SELECT
( CASE 
  WHEN ( SELECT val FROM contract_parameter_type_1 WHERE pid = 29 AND contract_parameter_type_1.cid = contract.id ) IS NULL
  THEN ( SELECT val FROM contract_parameter_type_1 WHERE pid = 2 AND contract_parameter_type_1.cid = contract.id )
  ELSE ( SELECT val FROM contract_parameter_type_1 WHERE pid = 29 AND contract_parameter_type_1.cid = contract.id )
  END ) as ABONENT,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 74 AND contract_parameter_type_1.cid = contract.id ) as PHONE,
( SELECT val FROM contract_parameter_type_6 WHERE pid = 58 AND contract_parameter_type_6.cid = contract.id ) as BIRTH_DAY,
( SELECT title FROM contract_parameter_type_7_values 
  LEFT JOIN contract_parameter_type_7 ON contract_parameter_type_7_values.id = contract_parameter_type_7.val 
  WHERE contract_parameter_type_7.pid = 80 AND contract_parameter_type_7.cid = contract.id ) as DOCUMENT_TYPE,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 76 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_SERIES,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 77 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_NUMBER,
( SELECT val FROM contract_parameter_type_6 WHERE pid = 27 AND contract_parameter_type_6.cid = contract.id ) as DOCUMENT_DATE,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 25 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_UNIT,
( SELECT val FROM contract_parameter_type_1 WHERE pid = 78 AND contract_parameter_type_1.cid = contract.id ) as DOCUMENT_UNIT_ID,
( SELECT house FROM address_house
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id
) as ADDR_HOUSE,
( SELECT address_street.title FROM address_street
  LEFT JOIN address_house ON address_street.id = address_house.streetid
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id
) as ADDR_STREET,
( SELECT address_city.title FROM address_city
  LEFT JOIN address_street ON address_city.id = address_street.cityid
  LEFT JOIN address_house ON address_street.id = address_house.streetid
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id 
) as ADDR_CITY,
( SELECT address_country.title FROM address_country
  LEFT JOIN address_city ON address_city.country_id = address_country.id
  LEFT JOIN address_street ON address_city.id = address_street.cityid
  LEFT JOIN address_house ON address_street.id = address_house.streetid
  LEFT JOIN contract_parameter_type_2 ON address_house.id = contract_parameter_type_2.hid
  WHERE contract_parameter_type_2.pid = 42 AND contract_parameter_type_2.cid = contract.id 
) as ADDR_COUNTRY,
contract.date1 as CONTR_DATE,
contract.title as CONTR_NUM,
contract.date2 as CONTR_END,
contract.status as STATUS,
contract.date1 as ACT_DATE
FROM
contract
ORDER BY contract.title;