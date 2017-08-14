class Question < ApplicationRecord
  belongs_to :user

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  before_save :prepare_text

  def prepare_text
    self.text.strip!
  end
end
