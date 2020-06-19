require 'rails_helper'

RSpec.describe Label, type: :model do
  context 'with validations' do
    it { should validate_presence_of(:name) }
  end
end
