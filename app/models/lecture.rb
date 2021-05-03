class Lecture < ApplicationRecord
  acts_as_paranoid

  has_many_attached :images

  has_many :article_insertions, -> { order('number ASC') }, class_name: 'ArticleLectureInsertion', inverse_of: :lecture
  accepts_nested_attributes_for :article_insertions, reject_if: :all_blank, allow_destroy: true

  has_many :articles, through: :article_insertions
  belongs_to :workshop, optional: true
  belongs_to :level, optional: true
  has_and_belongs_to_many :tools
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :languages

  validates :title, presence: true
  validates :number, presence: true

  def preview_image
    return preview_image_url if preview_image_url.present?
    workshop.image_url
  end

  def preview
    return self[:preview] if self[:preview]
    body
  end
end
