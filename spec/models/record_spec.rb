require 'rails_helper'

RSpec.describe Record, type: :model do
  context 'with validations' do
    subject { build(:record) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:blog) }
    it { should validate_presence_of(:display_name) }
    it { should validate_uniqueness_of(:display_name).scoped_to(:blog_id) }
  end

  it 'should have a valid factory' do
    expect(FactoryBot.build(:record).save).to be true
  end

  it 'scope should return published only' do
    b = FactoryBot.create :blog
    create_list(:record, 3, published: true, blog: b)
    create_list(:record, 2, published: false, blog: b)
    expect(Record.published.size).to eq 3
  end

  it 'scope should return published only' do
    b = FactoryBot.create :blog
    create_list(:record, 3, published: true, blog: b)
    create_list(:record, 2, published: false, blog: b)
    FactoryBot.create(:record, blog: b, published: true, published_at: Time.current.utc + 2.hours)
    expect(Record.published.size).to eq 3
  end

  it 'should set a published at date when published' do
    r = FactoryBot.create(:record, published: true, published_at: nil)
    expect(r.published_at).not_to be nil
  end
end
