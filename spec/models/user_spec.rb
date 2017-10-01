require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations and validations check' do
    it { should have_many :questions }
    it { should have_many :questions_asked }

    it { should validate_presence_of :email }
    it { should validate_presence_of :username }

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }

    it { should allow_value('good_email@example.com').for(:email) }
    it { should_not allow_value('not an email').for(:email) }

    it { should validate_length_of(:username).is_at_least(2).is_at_most(40) }

    it { should allow_value('user_name').for(:username) }
    it { should_not allow_value('#user@name').for(:username) }

    it { should allow_value('#fff').for(:avatar_bg_color) }
    it { should allow_value('#afafaf').for(:avatar_bg_color) }
    it { should_not allow_value('#fffa').for(:avatar_bg_color) }
    it { should_not allow_value('fffasd').for(:avatar_bg_color) }

    it { should allow_value('#fff').for(:avatar_border_color) }
    it { should allow_value('#afafaf').for(:avatar_border_color) }
    it { should_not allow_value('#fffa').for(:avatar_border_color) }
    it { should_not allow_value('fffasd').for(:avatar_border_color) }

    it { should allow_value('#fff').for(:profile_text_color) }
    it { should allow_value('#afafaf').for(:profile_text_color) }
    it { should_not allow_value('#fffa').for(:profile_text_color) }
    it { should_not allow_value('fffasd').for(:profile_text_color) }

    it { should validate_presence_of(:password).on(:create) }
    it { should validate_confirmation_of(:password) }
  end
end
