class Candidate < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :job_applications, dependent: :destroy
end
