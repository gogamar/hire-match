class Candidate < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :jobs
end
