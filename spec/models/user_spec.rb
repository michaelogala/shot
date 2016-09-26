require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Validations' do
    it { should validate_presence_of (:first_name) }
    it { should validate_presence_of (:last_name) }
    it { should validate_presence_of (:email) }
    it { should validate_presence_of (:password) }
    it { should have_db_index(:email) }
    it { should have_db_index(:first_name) }
    it { should have_db_index(:last_name) }
    it { should have_db_column(:link_count) }
  end

  context 'Associations' do
    it { should have_many (:links) }
  end

  context 'Scopes' do
    it 'should return users in order of their link count' do
      expect(User.top_users.order_values).to eq(['users.link_count DESC'])
    end
  end
end
