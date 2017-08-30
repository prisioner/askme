class Tag < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_name, against: :name, using: [:trigram]

  has_and_belongs_to_many :questions
  has_and_belongs_to_many :linked_tags, join_table: 'linked_tags_tags',
                          association_foreign_key: 'linked_tag_id', class_name: 'Tag'

  validates :name, presence: true, uniqueness: true, format: { with: TAG_REGEX }
  validates :alias, presence: true, uniqueness: true

  before_validation :downcase_name
  before_validation :generate_alias

  after_commit :find_and_link_same_tags, on: :create

  private

  def downcase_name
    self.name = name.mb_chars.downcase.to_s if name.present?
  end

  def generate_alias
    self.alias = name.delete('#') if name.present?
  end

  def find_and_link_same_tags
    self.linked_tags = Tag.search_by_name(self.name).where.not(name: self.name)
    self.linked_tags.each { |tag| tag.linked_tags << self }
  end
end
