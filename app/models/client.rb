class Client < ApplicationRecord
  has_many :projects, dependent: :restrict_with_exception
  has_many :events, through: :projects

  default_scope -> { order('LOWER(name) ASC') }
  validates_presence_of :name
end
