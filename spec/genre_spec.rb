require 'rspec'
require_relative '../genre'

describe Genre do
  let(:genre) { Genre.new("Action") }
  let(:item) { double("Item") }

  describe "#initialize" do
    it "sets the name and initializes an empty items array" do
      expect(genre.name).to eq("Action")
      expect(genre.items).to eq([])
    end
  end

  describe "#to_s" do
    it "returns the name of the genre" do
      expect(genre.to_s).to eq("Action")
    end
  end
end