class ArticleLectureInsertion < ApplicationRecord
  belongs_to :article#, optional: true
  belongs_to :lecture

  accepts_nested_attributes_for :article, reject_if: :all_blank, allow_destroy: true
end
