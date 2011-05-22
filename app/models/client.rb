class Client < ActiveRecord::Base
  has_many :projects
  has_many :events, :through => :projects
  
  default_scope order('name ASC')
  validates_presence_of :name
end
