class Question < ApplicationRecord
  belongs_to :interview
  has_many :answers, dependent: :destroy

  validates :number, presence: true
  validates :content, presence: true
  validates :content, uniqueness: { scope: :interview_id, message: "should be unique within the same interview" }
end
