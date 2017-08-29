class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :tags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  strip_attributes only: [:text, :answer]

  before_save :find_or_create_tags
  after_commit :destroy_unused_tags

  private

  def find_or_create_tags
    text_hashtags = self.text.scan(TAG_REGEX)
    answer_hashtags = self.answer.to_s.scan(TAG_REGEX)
    hashtags = text_hashtags | answer_hashtags

    self.tags = hashtags.map { |tag| Tag.find_or_create_by(name: tag) }
  end

  def destroy_unused_tags
    Tag.left_outer_joins(:questions).where(questions: { id: nil }).destroy_all
  end
end
