class Level < ApplicationRecord
  has_many :lectures

  validates :title, presence: true
end
