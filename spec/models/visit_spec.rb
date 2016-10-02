require 'rails_helper'

RSpec.describe Visit, type: :model do
  context 'Validations' do
    it { should validate_presence_of :ip_address }
    it { should validate_presence_of :browser_name }
    it { should validate_presence_of :os }
    it { should have_db_column :link_id }
    it { should have_db_column :referer }
  end

  context 'Associations' do
    it { should belong_to :link }
  end
end
