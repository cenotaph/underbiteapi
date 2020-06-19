require 'rails_helper'

RSpec.describe Record, type: :model do
  context 'with validations' do
    subject { build(:record) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:blog) }
    it { should validate_presence_of(:display_name) }
    it { should validate_uniqueness_of(:display_name).scoped_to(:blog_id) }
  end

  it 'should set a published at date when published' do
    r = FactoryBot.create(:record, published: true, published_at: nil)
    expect(r.published_at).not_to be nil
  end
end
