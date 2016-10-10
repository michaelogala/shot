require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Validations' do
    it { should have_secure_password }
    it { should validate_presence_of :first_name }
    it { should validate_length_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_length_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_length_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
    it { should validate_length_of :password }
    it { should validate_length_of :password_confirmation }
    it { should validate_confirmation_of :password }
    it { should have_db_index :email }
    it { should have_db_column :link_count }
    it { should have_db_column :password_digest }
  end

  context 'Associations' do
    it { should have_many :links }
  end

  context 'Scopes' do
    it 'should return users in order of their link count' do
      expect(User.top_users.order_values).to eq ['users.link_count DESC']
    end
  end
end
