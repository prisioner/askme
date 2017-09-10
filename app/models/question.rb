class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :tags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  strip_attributes only: [:text, :answer]

  after_commit :destroy_unused_tags

  private

  def destroy_unused_tags
    Tag.left_outer_joins(:questions).where(questions: { id: nil }).destroy_all
  end

  
end