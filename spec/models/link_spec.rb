require 'rails_helper'

RSpec.describe Link, type: :model do

  let(:google) { Link.create(given_url: 'http://google.com') }

  context 'Associations' do
    it { should have_many :visits }
    it { should belong_to :user }
  end

  context 'Validations' do
    subject { Link.new(given_url: 'http://youtube.com') }
    it { should validate_presence_of :given_url }
    it { should validate_presence_of :slug }
    it { should validate_uniqueness_of :slug }

    it { should have_db_column :slug }
    it { should have_db_column :title }
    it { should have_db_column :clicks }
    it { should have_db_column :user_id }
    it { should have_db_index :slug }
    it { should have_db_index :given_url }
  end

  context 'Named Scopes' do
    it 'should return the newest links first' do
      expect(Link.newest_first.order_values).to eq ['links.created_at DESC']
    end
    it 'should return popular links' do
      expect(Link.popular.order_values).to eq ['links.clicks DESC']
    end
  end
end
