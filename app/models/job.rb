class Job < ApplicationRecord
  belongs_to :company
  has_one :interview, dependent: :destroy
  has_and_belongs_to_many :candidates
  validates :title, presence: true
end
