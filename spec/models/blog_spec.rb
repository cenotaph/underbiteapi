require 'rails_helper'

RSpec.describe Blog, type: :model do
  context 'with validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name) }
  end
end
