require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_length_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_length_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of :email }
    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_presence_of :password_confirmation }
    it { is_expected.to validate_length_of :password }
    it { is_expected.to validate_length_of :password_confirmation }
    it { is_expected.to validate_confirmation_of :password }
    it { is_expected.to have_db_index :email }
    it { is_expected.to have_db_column :link_count }
    it { is_expected.to have_db_column :password_digest }
  end

  describe 'associations' do
    it { is_expected.to have_many :links }
  end

  describe 'instance methods' do
    let(:user) { create(:user) }
    subject { user }

    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :last_name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :password }
    it { is_expected.to respond_to :password_confirmation }
    it { is_expected.to respond_to :link_count }
    it { is_expected.to respond_to :password_digest }

    describe '#add_new_link' do
      let(:link) { create(:link) }
      before { user.links << link }
      it 'should save the link to the user instance' do
        expect(user.links.count).to eq 1
      end
    end
  end

  describe 'class methods' do
    let(:user) { create(:user) }

    describe '.find_by_email' do
      it 'should return a user object' do
        expect(User.find_by_email(user.email)).to eq user
      end
    end

    describe '.top_users' do
      it 'should return users in order of their link count' do
        expect(User.top_users.order_values).to eq ['users.link_count DESC']
      end
    end
  end
end
