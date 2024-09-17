class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { company: 0, candidate: 1, admin: 2 }

  has_one :candidate, dependent: :destroy
  has_one :company, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :role, presence: true

  after_create :create_associated_record

  private

  def create_associated_record
    case role
    when 'candidate'
      Candidate.create!(user: self)
    when 'company'
      Company.create!(user: self)
    end
  end
end
