class Client < ActiveRecord::Base
  has_many :projects
  default_scope order('name ASC')
  validates_presence_of :name
end
