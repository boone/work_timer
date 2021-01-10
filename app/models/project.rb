class Project < ApplicationRecord
  belongs_to :client
  has_many :events, dependent: :restrict_with_exception
  default_scope -> { order(Arel.sql('LOWER(title) ASC')) }
  validates_presence_of :title
end
