def open_url url
  Net::HTTP.get URI.parse(url)
end

def remove_empty_lines doc
  doc.xpath("//text()").select{|t| t.to_s.strip == ""}.map(&:remove)
end

namespace :disease do
  desc "TODO"
  task crawl: :environment do
    require "nokogiri"
    require "net/http"
    BASE_URL = "https://vicare.vn".freeze
    DISEASE_URL = "https://vicare.vn/benh/".freeze

    def crawl_disease name, url
      page = Nokogiri::HTML open_url(url)
      content = page.css("div.content")[0].css("div.body.collapsible-target")[1]
      content.css(".media").remove
      remove_empty_lines content
      Disease.create! name: name, content_html: content
      puts name
    end

    root_page = Nokogiri::HTML open_url(DISEASE_URL)
    main_div = root_page.css("div.content")
    sections = main_div.css("section.disease-body")
    sections.shift
    sections.each do |e|
      e.css("li").each do |li|
        node = li.css("a")[0]
        crawl_disease node.content, "#{BASE_URL}#{node['href']}"
      end
    end
  end
end
