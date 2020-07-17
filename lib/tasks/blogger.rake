require 'rexml/document'
require 'uri'

namespace :blogger do

  desc 'match tags'
  task tags: [:environment] do
    xmlfile = '/Users/fail/fetched/blog.xml'
    xmldoc = REXML::Document.new(File.new(xmlfile))
    blog = Blog.friendly.find('7s')
    i= -1
    xmldoc.elements.each('feed/entry') do |e|
      i = i+1
      next if i>648
      next if e.elements['id'].text !~ /\.post\-/
      next if e.elements['title'].text =~ /^Template:/
      review = e.elements['content'].text
      # puts e.elements['title'].text
      existing = Record.find_by(display_name: e.elements['title'].text)
      if existing.nil?
        puts 'Cannot find ' + e.elements['title'].text

      else
        e.get_elements('.//category').each do |cat|
          next if cat.attributes['term'] =~ /http/
          existing.tag_list.add(cat.attributes['term'])
        end
        existing.save
        # puts 'Found : ' + e.elements['title'].text
      end
    end
  end


  desc 'convert to db'
  task import: [:environment] do
    xmlfile = '/Users/fail/fetched/blog.xml'
    xmldoc = REXML::Document.new(File.new(xmlfile))
    blog = Blog.friendly.find('7s')
    root = xmldoc.root
    i = -1
    xmldoc.elements.each('feed/entry') do |e|
      i = i+1
      next if i>648
      # puts e.elements['id'].text
      next if e.elements['id'].text !~ /\.post\-/
      next if e.elements['title'].text =~ /^Template:/
      record = Record.new
      record.display_name = e.elements['title'].text.gsub(/\u200e/, ' ').gsub(/[\x00-\x1F\x7F]/, '')
  
      titlelabel = record.display_name.split(/\s+\-\s+/, 2)
      if titlelabel.size > 1
        artist = record.display_name.split(/\s+\-\s+/, 2)[0]
        tl = titlelabel[1].split(/'\s\(/)
        if tl.size > 1
          record.title = tl[0].gsub(/^'/, '').gsub(/'$/, '')
          label = tl[1].gsub(/\)$/, '')
        else
          tll =  tl[0].split(/\s\(/)
          record.title = tll[0]
          label = tll[1].gsub(/\)$/, '')
        end
      else
        artistlabel = record.display_name.split(/\s\(/)
        artist = artistlabel[0]
        label = artistlabel[1].gsub(/\)$/, '')
      end
      record.review = e.elements['content'].text
      puts ' '
      puts i.to_s
      
      artists = artist.split(/\//)
      artists.each do |ar|
        record.artists << Artist.find_or_create_by(name: ar.strip)
        puts 'Artist: ' + ar.strip
      end
      if record.title.blank?
        record.title = artist.strip
      end
      puts 'Title: ' + (record.title.nil? ? artist : record.title)
      labels = label.split(/\//)
      labels.each do |l|
        record.labels << Label.find_or_create_by(name: l.strip)
        puts 'Label: ' + l.strip

      end
      # puts record.inspect

      parsed_data = Nokogiri::HTML.parse(record.review)
      img = parsed_data.xpath("//img")
      remote_url =  img[0][:src]
      begin
        uri = URI.parse(remote_url)
        file = URI.open(remote_url)
        filename = File.basename(uri.path)
        record.image.attach(io: file, filename: filename)
      rescue
        puts "missing: " + remote_url
      end
      record.published = true
      record.published_at = e.elements['published'].text
      record.blog = blog
      if record.save
        puts 'Saved record ok!'
      else
        puts record.errors.inspect
        # exit
      end


      
      # e.elements.each('title/__text') do |t|
        # puts t.inspect
      # end
      # puts e.text
    end
  end
end