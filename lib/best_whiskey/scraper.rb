class BestWhiskey::Scraper
	attr_accessor :whiskey_urls

	BASE_URL = 'http://www.worldwhiskiesawards.com/'
	
	def initialize
		@whiskey_urls = []
	end
	
	def get_years_pages
		base_doc = noko_open(BASE_URL+'2015/')
		base_doc.css("nav.results li a").text.scan(/20\d\d/).map do |year|
			BASE_URL+"#{year}"
		end
	end

	def get_whiskey_urls_main
		get_years_pages.each do |url|
			whiskey_urls << BASE_URL+noko_open(url).css('div.winner_main a').attribute('href').value
		end
	end

	def get_whiskey_urls_sub
		get_years_pages.each do |url|
			noko_open(url).css('div.winner_sub p.image a').each do |sub|
				whiskey_urls << BASE_URL+sub.attribute('href').value
			end
		end
	end

	def get_whiskey_urls
		get_whiskey_urls_main
		get_whiskey_urls_sub
		whiskey_urls
	end

	def make_whiskies

	end
 
	def scrape_whiskey_from_url(url)
		whiskey = {}
		whiskey[:name] = noko_open(url).css("section.details h1").text
		noko_open(url).css("section.details h1").text
	end

	def noko_open(url)
		Nokogiri::HTML(open(url))
	end


end

