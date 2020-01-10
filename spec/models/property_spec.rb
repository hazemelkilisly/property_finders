require 'spec_helper'

RSpec.describe Property, :type => :model do

  context "Validations check" do
    it "When initialized with wrong :lat" do
      property = FactoryBot.build(:property, lat: '95', lng: Faker::Address.longitude)
      expect(property).to_not be_valid
    end

    it "When initialized with wrong :lng" do
      property = FactoryBot.build(:property, lng: '185', lat: Faker::Address.latitude)
      expect(property).to_not be_valid
    end

    it "When initialized with wrong :price" do
      property = FactoryBot.build(:property, price: -10)
      expect(property).to_not be_valid
    end

    it "When everything is correct" do
      property = FactoryBot.build(:property)
      expect(property).to be_valid
    end
  end
end
