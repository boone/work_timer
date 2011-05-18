class Project < ActiveRecord::Base
  belongs_to :client
  has_many :events
  default_scope order('title ASC')
  validates_presence_of :title
end
