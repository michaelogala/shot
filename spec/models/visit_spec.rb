require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :ip_address }
    it { is_expected.to validate_presence_of :browser_name }
    it { is_expected.to validate_presence_of :os }
    it { is_expected.to have_db_column :link_id }
    it { is_expected.to have_db_column :referer }
  end

  describe 'associations' do
    it { is_expected.to belong_to :link }
  end

  describe 'instance methods' do
    subject { build(:visit) }

    it { is_expected.to respond_to :ip_address }
    it { is_expected.to respond_to :browser_name }
    it { is_expected.to respond_to :os }
    it { is_expected.to respond_to :link_id }
    it { is_expected.to respond_to :referer }
  end
end
