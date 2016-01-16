class BestWhiskey::ContestYear
	attr_accessor :whiskies, :winning_year

	@@all = ["2007", '2008','2009', "2010", "2011"]

	def initialize(winning_year = nil)
		@winning_year = winning_year
		@whiskies = []
		@@all << self
	end

	def self.find_by_year(year)
		self.all.detect { |w| w.winning_year = year}
	end

	def self.add_whiskey(whiskey)
		@whiskies << whiskey
	end

	def self.all 
		@@all
	end
end

binding.pry
