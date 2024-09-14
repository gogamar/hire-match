class Interview < ApplicationRecord
  belongs_to :job
  has_many :questions, dependent: :destroy
end
