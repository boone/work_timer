class Project < ActiveRecord::Base
  belongs_to :client
  has_many :events, :dependent => :restrict
  default_scope order('LOWER(title) ASC')
  validates_presence_of :title
end
