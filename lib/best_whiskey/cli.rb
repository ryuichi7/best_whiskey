# CLI controller
class BestWhiskey::CLI

	NEW_LINE = "\n".freeze

	LINE = ('-' * 12).freeze

	WELCOME_MESSAGE = "#{NEW_LINE}#{LINE} Welcome to the Best Whiskies of the Year CLI!" +
										  "#{LINE}#{NEW_LINE*2}".freeze

	ENTER_YEAR_MESSAGE = "#{NEW_LINE}Please enter the number of the year" +
													" you'd like to explore. Enter 'e' at anytime to exit".freeze

	LIST_WINNERS_MESSAGE = "#{NEW_LINE}#{LINE} Here are the list of winners for ".freeze

	def call
		puts WELCOME_MESSAGE
		list_years
	end

  
  def list_years
  	puts ENTER_YEAR_MESSAGE
  	years_list
  	input = read
  	return if exit?(input)
  	if integer?(input) && input.to_i <= contest_years.size
  		whiskey_list(input)	
  	else 
  		invalid
  		list_years
  	end
  end

  def whiskey_list(input)
  	puts winners_message(contest_years, input)
  	year = contest_years[input.to_i - 1]
  	year.whiskies.each_with_index { | whiskey, index | puts "#{index + 1}. #{whiskey.name}" }
  	puts "\nPlease enter the number of the whiskey you'd like to explore. Enter 'e' at anytime to exit"
  	input = read
  	return if exit?(input)
  	if integer?(input) && input.to_i <= year.whiskies.size
  		whiskey = year.whiskies[input.to_i - 1]	
  		attributes.each do |a|
  			attribute = whiskey.send(a)
  			puts "#{a}: #{attribute}" unless attribute == nil
  		end
  		next_step
	  else
	  	invalid
	  	whiskey_list(input)
  	end
  end

	def exit?(input)
		input == 'e'
	end


	def next_step
  	puts "\nWould you like to see another whiskey? enter Y/N"
  	input = read
  	if input == 'y'
  		list_years
  	elsif input == 'n' || input == 'e'
  		puts "\nThank you for visiting the Whiskey of the Year CLI!"
		else
			invalid
	  	next_step
	  end
	end
  
  def years_list
  	#somehow scrape to get list of available years and create array
  	contest_years.each_with_index do |year,index|
  		puts "#{index+1}. #{year.year}"
  	end
  end

  def contest_years
  	@contest_years ||= BestWhiskey::ContestYear.all
  end

  def read
  	gets.strip.downcase 
  end

  def attributes
  	BestWhiskey::Whiskey.attributes
  end

  def invalid
  	puts "\nSorry that's not a valid input"
  end

  def winners_message(years, input)
		"#{LIST_WINNERS_MESSAGE}#{years[input.to_i - 1].year}" +
		  " #{LINE}#{NEW_LINE*2}"
	end

	def integer?(value)
		value =~ /[\d]/
	end


end
