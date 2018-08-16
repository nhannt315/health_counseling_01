def remove_empty_lines doc
  doc.xpath("//text()").select{|t| t.to_s.strip == ""}.map(&:remove)
end

def open_url url
  Net::HTTP.get(URI.parse(url))
end

def crawl_medicine name, company, type_id, path
  puts name
  medicine = Medicine.new name: name, company: company,
                          medicine_type_id: type_id
  url = "#{BASE_URL}#{path}"
  medicine_page = Nokogiri::HTML(open_url(url))
  content = medicine_page.css(".drug-body")
  remove_empty_lines content
  section_list = content.css("section")
  base_count = section_list.length > 9 ? 1 : 0
  if base_count == 1 && content.css(".item img")[0]
    medicine.image = content.css(".item img")[0]["src"]
  end
  # Tom tat thuoc
  medicine.overview = get_detail_content section_list, base_count
  # Huong dan su dung
  medicine.instruction = get_detail_content section_list, base_count + 1
  # Thong tin duoc chat
  medicine.info = get_detail_content section_list, base_count + 2
  # Canh bao
  medicine.warning = get_detail_content section_list, base_count + 3
  # Chong chi dinh
  medicine.contraindication = get_detail_content section_list,
    base_count + 4
  # Tac dung phu
  medicine.side_effect = get_detail_content section_list, base_count + 5
  # Luu y
  medicine.note = get_detail_content section_list, base_count + 6
  # Qua lieu
  medicine.overdose = get_detail_content section_list, base_count + 7
  # Bao quan
  medicine.preservation = get_detail_content section_list, base_count + 8

  if medicine.save
    puts "Success!"
  else
    puts "Failed!"
  end
end

namespace :medicine do
  desc "TODO"
  task crawl: :environment do
    require "nokogiri"
    require "net/http"
    BASE_URL = "https://vicare.vn".freeze
    MEDICINE_URL = "https://vicare.vn/thuoc/".freeze

    def get_detail_content element, index
      return unless element[index]
      content = element[index].css(".collapsible-target")
      remove_empty_lines content
    end

    def crawl_medicine_type name, class_id, path
      medicine_type = MedicineType.create! name: name,
                                           medicine_class_id: class_id
      url = "#{BASE_URL}#{path}"
      medicines_page = Nokogiri::HTML(open_url(url))
      medicines_page.css(".item").each do |item|
        name = item.css(".c-media__title").text
        company = item.css(".c-media__content").text
        path = item.css(".c-media")[0]["href"]
        crawl_medicine name, company, medicine_type.id, path
      end
    end

    page = Nokogiri::HTML(open_url(MEDICINE_URL))

    page.css(".item").each do |item|
      class_name = item.css("h3").text
      medicine_class = MedicineClass.create! name: class_name
      item.css("li").each do |li_item|
        name = li_item.css("a").text
        path = li_item.css("a")[0]["href"]
        crawl_medicine_type name, medicine_class.id, path
      end
    end
  end

  task delete_all: :environment do
    puts "Deleting Medicine"
    Medicine.delete_all
    puts "Deleting Medicine Type"
    MedicineType.delete_all
    puts "Deleting Medicine Class"
    MedicineClass.delete_all
  end
end
