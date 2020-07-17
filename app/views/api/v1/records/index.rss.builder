xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Dislocated Underbite Spinal Alphabetised Encourager Templates"
    xml.description "Listening to my records in alphabetical order, since 2009."
    xml.link 'https://vinylunderbite.com/'
    xml.tag! 'atom:link', href: 'https://api.vinylunderbite.com/v1/records.rss', rel: :self, type: 'application/rss+xml'

    for post in @records
      xml.item do
        unless post.image.filename.nil?
          xml.media(:content, url: post.image.url, "xmlns:media" => "http://search.yahoo.com/mrss/")
          xml.media(:thumbnail, url:  post.image.url, "xmlns:media" => "http://search.yahoo.com/mrss/")
        end
        xml.title post.display_name
        xml.description(h(post.review))
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link 'https://vinylunderbite.com/' + post.blog.slug + '/' + post.slug
        xml.guid 'https://vinylunderbite.com/' + post.blog.slug + '/' + post.slug

      end
    end
  end
end