class BestWhiskey::Scraper
	attr_accessor :whiskey_urls

	BASE_URL = 'http://www.worldwhiskiesawards.com/'
	
	def initialize
		@whiskey_urls = []
	end
	
	def get_years_pages
		base_doc = noko_open(BASE_URL + '2015/')
		base_doc.css("nav.results li a").text.scan(/20\d\d/).map do |year|
			BASE_URL + year
		end
	end

	def get_whiskey_urls_main
		get_years_pages.each do |url|
			whiskey_urls << BASE_URL + noko_open(url).css('div.winner_main a').attribute('href').value
		end
	end

	def get_whiskey_urls_sub
		get_years_pages.each do |url|
			noko_open(url).css('div.winner_sub p.image a').each do |sub|
				whiskey_urls << BASE_URL + sub.attribute('href').value
			end
		end
	end

	def get_whiskey_urls
		get_whiskey_urls_main
		get_whiskey_urls_sub
		whiskey_urls.uniq
	end

	def make_whiskies
		get_whiskey_urls.each do |url|
			w = scrape_whiskey_from_url(url)
			BestWhiskey::Whiskey.create_whiskey_from_scrp(w)
		end	
	end
 
	def scrape_whiskey_from_url(url)
		@whiskey = {}
		assign_name(url)
		assign_award(url)
		assign_winning_year(url)
		assign_description(url)

		noko_open(url).css("ul.details li").each do |details|
			d = details.text.split(" ")
			@whiskey[d.first.gsub(":","").downcase.to_sym] = d.drop(1).join(" ").downcase unless d.first == 'Website:'
		end 
		@whiskey
	end

	def noko_open(url)
		Nokogiri::HTML(open(url))
	end

	def assign_award(url)
		award = noko_open(url).css("span.award").map { |a| a.text.downcase }
		@whiskey[:award] = award
	end

	def assign_winning_year(url)
		year = noko_open(url).css("span.year").map { |y| y.text }
		@whiskey[:winning_year] = year
	end

	def assign_name(url)
		@whiskey[:name] = noko_open(url).css("section.details h1").text.downcase
	end

	def assign_description(url)
		description = noko_open(url).css("div.award-wrapper p").first.text.strip
		@whiskey[:description] = description if description != ""
	end

end

