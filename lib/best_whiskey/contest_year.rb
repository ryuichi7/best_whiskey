class BestWhiskey::ContestYear
	attr_accessor :whiskies, :year

	@@all = []

	def initialize(year = nil)
		@year = year
		@whiskies = []
		@@all << self
	end

	def self.find_by_year(year)
		self.all.detect { |w| w.year == year}
	end
#is the overwriting happening here? check for duplication, find out how to account for that.
	def self.find_or_create_by_year(year)
		self.find_by_year(year) || self.create(year)
	end

	def add_whiskey(whiskey)
		@whiskies << whiskey
	end

	def self.all 
		@@all
	end

	def self.create(year)
    self.new(year)
  end
end




