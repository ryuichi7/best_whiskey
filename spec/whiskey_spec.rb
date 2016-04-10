require 'spec_helper'

describe BestWhiskey::Whiskey do 

	it 'can be initialized with only select attributes' do
		attributes = { name: "Mcallan", vintage: 2012, abv: '40%' }
		whiskey = BestWhiskey::Whiskey.new(attributes)
		expect(whiskey.name).to eq("Mcallan")
		expect(whiskey.vintage).to eq(2012)
		expect(whiskey.abv).to eq('40%')
	end

	it 'can be initialized with another set of arbitrary attributes' do
		attributes = { name: "Some other whiskey", category: "the best", description: "tasty" }
		whiskey = BestWhiskey::Whiskey.new(attributes)
		expect(whiskey.name).to eq("Some other whiskey")
		expect(whiskey.category).to eq("the best")
		expect(whiskey.description).to eq("tasty")
	end
end


			