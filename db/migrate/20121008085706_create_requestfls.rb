class CreateRequestfls < ActiveRecord::Migration
  def change
    create_table :requestfls do |t|
      t.column :id, :int, :primary => true, :null => false # ID
      t.column :description, :string, :null => true # Дополнительная информация / текст
      t.column :fio, :string, :limit => 70, :null => false # ФИО
      t.column :adress_post, :string, :limit => 150, :null => false # Адресс почтовый
      t.column :adress_connection, :string, :limit => 150, :null => false # Адресс подключения
      t.column :latlng_connection, :string, :limit => 100, :null => false # Координаты подключения
      t.column :email, :string, :limit => 40, :null => false # Почтовый ящик
      t.column :telephone, :string, :limit => 13, :null => false # Телефон
      t.column :in, :string, :limit => 30, :null => false # Идентификационный код
      t.column :pasport, :string, :limit => 20, :null => false # Паспорт номер/серия
      t.column :pasport_authority, :string, :limit => 60, :null => false # Паспорт кем выдан
      t.column :pasport_date, :date # Паспорт когда выдан
      t.column :payment_form, :integer, :null => false # Форма оплаты
      t.column :ip, :string, :limit => 15, :null => false # IP
      t.column :login, :string, :limit => 15, :null => false # IP
      t.column :password, :string, :limit => 15, :null => false # IP
      t.column :user_id, :integer, :null => false # id создателя заявки
      t.column :technology, :integer, :null => false # Технология подключения
      t.column :node, :integer, :null => false # Точка подключения
      t.column :requeststatus_id, :integer, :default => 1, :null => false # Статус заявки на подключение
      t.column :tariffplan_id, :integer, :null => false # id Тарифа
      t.timestamps
    end
  end
end
