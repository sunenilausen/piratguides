class Language < ApplicationRecord
  has_and_belongs_to_many :lectures

  validates :title, presence: true
end
