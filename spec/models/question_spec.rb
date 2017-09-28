require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations and validations check' do
    it { should belong_to :user }
    it { should belong_to :author }
    it { should have_and_belong_to_many :tags }

    it { should validate_presence_of :text }
    it { should validate_presence_of :user }
    it { should_not validate_presence_of :author }

    it { should validate_length_of(:text).is_at_most(255) }
  end
end
