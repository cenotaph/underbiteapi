RSpec.describe "Records", type: :request do

  describe "request records by tag" do
    before do
      blog = FactoryBot.create(:blog, name: 'lps')
      FactoryBot.create_list(:record, 4, blog: blog)
      f = FactoryBot.create_list(:record, 5, blog: blog)
      f.each do |rec|
        rec.tag_list.add('fuckery')
        rec.save
      end
      get v1_blog_records_path(blog_id: 'lps', by_tag: 'fuckery')
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should have only 5 records' do
      expect(json['data'].size).to eq 5
    end
  end

  describe "request list of all records by blog" do
    before do
      blog = FactoryBot.create(:blog, name: 'lps')
      FactoryBot.create_list(:record, 14, blog: blog)
      get v1_blog_records_path(blog_id: 'lps')
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "should have 14 records" do
      expect(json['data'].size).to eq 14
    end
  end


  describe "request list of all records across all blogs" do
    before do
      blog = FactoryBot.create(:blog, name: 'lps')
      blog2 = FactoryBot.create(:blog, name: 'cds')
      FactoryBot.create_list(:record, 4, blog: blog)
      FactoryBot.create_list(:record, 5, blog: blog2)

      get v1_records_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "should have 9 records" do
      expect(json['data'].size).to eq 9
    end
  end
end
