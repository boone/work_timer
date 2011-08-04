class Client < ActiveRecord::Base
  has_many :projects, :dependent => :restrict
  has_many :events, :through => :projects
  
  default_scope order('LOWER(name) ASC')
  validates_presence_of :name
end
