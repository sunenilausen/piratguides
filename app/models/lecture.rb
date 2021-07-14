class Lecture < ApplicationRecord
  acts_as_paranoid

  has_one_attached :banner
  has_many_attached :images
  has_many_attached :resources

  has_many :article_insertions, -> { order('number ASC') }, class_name: 'ArticleLectureInsertion', inverse_of: :lecture
  accepts_nested_attributes_for :article_insertions, reject_if: :all_blank, allow_destroy: true

  has_many :articles, through: :article_insertions
  belongs_to :workshop, optional: true
  belongs_to :level, optional: true
  has_and_belongs_to_many :tools
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :languages

  belongs_to :author, class_name: "User", inverse_of: :lectures

  validates :title, presence: true
  validates :number, presence: true
  validates :community, inclusion: [true],if: Proc.new { |l| l.author.volunteer? }

  def preview_image
    return preview_image_url if preview_image_url.present?
    return workshop.image_url if workshop.present?
    ActionController::Base.helpers.image_url "hack-logo.png"
  end

  def preview
    return self[:preview] if self[:preview]
    body
  end
end
