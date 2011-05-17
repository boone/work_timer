class Project < ActiveRecord::Base
  belongs_to :client
  has_many :events
  default_scope order('title ASC')
end
