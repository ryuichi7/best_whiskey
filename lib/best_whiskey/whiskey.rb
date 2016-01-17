# This class ...
class BestWhiskey::Whiskey

	attr_accessor :name,
								:abv,
								:category,
								:style,
								:country,
								:producer,
								:description,
								:age,
								:winning_year

	@@all = []

	def initialize(attribute_array)
		attribute_array.each do | k, v |
			self.send( "#{k}=", v )
		end
		#method that adds whiskey object to winning_year object's array 
		#winning_year.add_whiskey(self) 
		@@all << self
	end

#create method that finds contest_year object and adds whiskey object to it's array 
	def self.create_whiskey_from_scrp(attribute_array)
		self.new(attribute_array).tap do |whiskey|
			whiskey.associate_year(whiskey.winning_year)
			whiskey.winning_year.add_whiskey(whiskey)
		end
	end

#need to figure out how to allow a whiskey to have two winning years. also keep from overwriting another year
	def associate_year(year)
		year = BestWhiskey::ContestYear.find_by_year(year)
		self.winning_year = year
	end

	def self.all
		@@all
	end

	def self.attributes
		[ :name,
		  :abv,
			:category,
			:style,
			:country,
			:producer,
			:description,
			:age
		]
	end
end


binding.pry