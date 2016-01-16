# CLI controller
class BestWhiskey::CLI

	def call
		puts ''
		puts "------------- Welcome to the Best Whiskies of the Year Gem! ------------"
		list_years
	end

  
  def list_years
  	puts ''
  	puts "Please enter the number of the year you'd like to explore"
  	years_list
  	input = read
  	until input == "exit"
	  	if input.to_i == 0
	  		list_years
	  	elsif input.to_i <= contest_years.size
	  		puts "------------- Here are the list of winners for #{contest_years[input.to_i - 1]} ------------"
	  		whiskey_list(input)
  		end
  	end
  end

  def whiskey_list(input)
  	year = contest_years[input.to_i - 1]
  	year.whiskies.each_with_index { | whiskey, index | puts "#{index + 1}. #{whiskey}" }
  	puts "Please enter the number of the whiskey you'd like to explore"
  	input = read
  	year.whiskies[input.to_i - 1]. each do |k,v|
  		puts "#{key}: #{value}"
  	end

  end


  def years_list
  	#somehow scrape to get list of available years and create array
  	contest_years.each_with_index do |year,index|
  		puts "#{index+1}. #{year}"
  	end
  end

  def contest_years
  	BestWhiskey::ContestYear.all
  end

  def read
  	gets.strip.downcase 
  end
end

