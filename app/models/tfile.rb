# coding: utf-8
class Tfile < ActiveRecord::Base
 # attr_accessor :file_file_name, :file_content_type , :file_file_size
  attr_accessible :file, :title, :task_id

  belongs_to :task
  has_attached_file :file, :path => "/var/www/wemonfiles/:attachment/:id.:extension", 
  						   :url => "/:attachment/:id.:extension"

#  has_attached_file :file, :path => "/var/www/wemonfiles/:attachment/:id.:extension", 
#  						   :url => "public/:attachment/:id.:extension"

  validates :file, :attachment_presence => {:message => "Файл не добавлен" }

  validates :title, :length =>{ :maximum => 120, 
  					            :message => "Размер заголовка не может привышать 120 символов" }, 
  		            :allow_blank => true, 
  		            :allow_nil => true

#  validates :text, :length =>{ :maximum => 360, 
#  				               :message => "Размер заголовка не может привышать 360 символов" }, 
#                   :allow_blank => true, 
#                   :allow_nil => true
end
