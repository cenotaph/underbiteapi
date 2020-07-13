xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dislocated Underbite Spinal Alphabetised Encourager Templates"
    xml.description "Listening to my records in alphabetical order, since 2009."
    xml.link 'https://vinylunderbite.com/'

    for post in @records
      xml.item do
        withimg = ''
        unless post.image.filename.nil?
          withimg += image_tag post.image.url 
        end
        withimg += '<br />' + post.review
        xml.title post.display_name
        xml.description withimg, type: :html
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link v1_records_url(post)
        xml.guid v1_records_url(post)

      end
    end
  end
end