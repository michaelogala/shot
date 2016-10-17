require 'rails_helper'

RSpec.describe Link, type: :model do

  let(:google) { Link.create(given_url: 'http://google.com') }

  describe 'associations' do
    it { is_expected.to have_many :visits }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    subject { Link.new(given_url: 'http://youtube.com') }
    it { is_expected.to validate_presence_of :given_url }
    it { is_expected.to validate_uniqueness_of :slug }

    it { is_expected.to have_db_column :slug }
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :clicks }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_index :slug }
    it { is_expected.to have_db_index :given_url }
  end

  describe 'instance methods' do
    let(:link) { build(:link) }
    subject { link }

    it { is_expected.to respond_to :given_url }
    it { is_expected.to respond_to :slug }
    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :clicks }

    describe '#sanitize_slug' do
      before do
        link.slug = 'some slug'
        link.sanitize_slug
      end
      it 'replaces spaces in slug with hyphen' do
        expect(link.slug).to eq 'some-slug'
      end
    end

    describe '#generate_slug' do
      before { link.generate_slug }
      it 'has a valid slug' do
        expect(link.slug).to_not be_nil
      end
    end

    describe '#display_slug' do
      before { link.save }
      it 'returns the full path with a slug' do
        expect(link.display_slug).to eq ENV['BASE_URL'] + link.slug.to_s
      end
    end

    describe '#add_visit_info' do
      let(:visit) { create(:visit) }
      before do
        link.save
        link.add_visit_info(visit)
      end
      it 'persists the visit info to the link' do
        expect(link.visits.count).to eq 1
      end
      it 'increases the link click count by 1' do
        expect(link.clicks).to eq 1
      end
    end
  end

  describe 'class methods' do
    let(:link) { create(:link) }
    describe '.newest_first' do
      it 'returns the newest links first' do
        expect(Link.newest_first.order_values).to eq ['links.created_at DESC']
      end
    end

    describe '.popular' do
      it 'returns popular links' do
        expect(Link.popular.order_values).to eq ['links.clicks DESC']
      end
    end

    describe '.find_links_for_user' do
      let(:user) { create(:user) }
      before { user.links << link }
      it 'returns an array of links that belong to a user' do
        expect(Link.find_links_for_user(user)).to eq [link]
      end
    end

    describe '.find_by_id' do
      it 'returns a link object when given a valid id' do
        expect(Link.find_by_id(link.id)).to eq link
      end
    end
  end
end
