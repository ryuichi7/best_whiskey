class BestWhiskey::Whiskey

	attr_accessor :name,
								:award,
								:abv,
								:category,
								:style,
								:country,
								:producer,
								:description,
								:age,
								:winning_year,
								:vintage

	@@all = []

	def initialize(attribute_hash = {})
		attribute_hash.each do | k, v |
			self.send( "#{k}=", v )
		end
		@@all << self
	end

	def self.create_whiskey_from_scrp(attribute_hash)
		self.new(attribute_hash).tap do |whiskey|
			whiskey.associate_year(whiskey.winning_year)
			whiskey.winning_year.each { |w| w.add_whiskey(whiskey) }
		end
	end

	def associate_year(year)
		self.winning_year = year.map { |year| BestWhiskey::ContestYear.find_or_create_by_year(year) }
	end

	def self.all
		@@all
	end

	def self.attributes
		[ :name,
			:award,
		  :abv,
			:category,
			:style,
			:country,
			:producer,
			:description,
			:age,
			:vintage
		]
	end
end


