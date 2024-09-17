class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_many :answers, dependent: :destroy
end
