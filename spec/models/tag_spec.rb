require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations and validations check' do
    it { should have_and_belong_to_many :questions }
    it { should have_and_belong_to_many :linked_tags }

    it { should validate_presence_of :name }
    it { should validate_presence_of :alias }

    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_uniqueness_of :alias }
  end
end
