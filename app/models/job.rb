class Job < ApplicationRecord
  belongs_to :company
  has_one :interview, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :title, presence: true
end
