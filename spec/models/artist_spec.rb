require 'rails_helper'

RSpec.describe Artist, type: :model do
  context 'with validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:alphabetical_name) }
  end

  it 'should set an alphabeical name if otherwise blank' do
    r = FactoryBot.create(:artist)
    expect(r.alphabetical_name).to eq r.name
  end

end
