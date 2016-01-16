class BestWhiskey::Whiskey
	attr_accessor :name, :abv, :category, :style, :country, :producer, :description, :age, :winning_year

@@all = []

	def initialize(attribute_array)
		attribute_array.each do | k, v |
			self.send( "#{k}=", v )
		end
		#winning_year.add_whiskey(self)
		@@all << self
	end

#create method that finds contest_year object and adds whiskey object to it's array 
	def create_whiskey_from_scrp(attribute_array)
		whiskey = self.new(attribute_array)
		whiskey.winning_year_object = whiskey.winning_year
	end

	def winning_year_object=(year)
		year = BestWhiskey::ContestYear.find_by_year(year)
		self.winning_year = year
	end

end

