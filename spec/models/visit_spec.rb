require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe 'validations' do
    it { should validate_presence_of :ip_address }
    it { should validate_presence_of :browser_name }
    it { should validate_presence_of :os }
    it { should have_db_column :link_id }
    it { should have_db_column :referer }
  end

  describe 'associations' do
    it { should belong_to :link }
  end

  describe 'instance methods' do
    subject { build(:visit) }

    it { should respond_to :ip_address }
    it { should respond_to :browser_name }
    it { should respond_to :os }
    it { should respond_to :link_id }
    it { should respond_to :referer }
  end
end
