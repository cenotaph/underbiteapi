require 'rails_helper'

RSpec.describe 'Searching', type: :request do
  describe 'search records by a term' do
    before do
      blog = FactoryBot.create(:blog, name: 'lps')
      FactoryBot.create_list(:record, 4, blog:)
      FactoryBot.create(:record, display_name: 'Sebadoh', blog:)
      FactoryBot.create(:record, review: 'Sebadoh sucks', blog:)

      post v1_search_path, params: { search: 'sebadoh' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should have 2 records' do
      expect(json['data'].size).to eq 2
    end
  end
end
