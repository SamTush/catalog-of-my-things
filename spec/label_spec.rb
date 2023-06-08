require_relative '../label'
require_relative '../item'

RSpec.describe Label do
  let(:id) { 1 }
  let(:name) { "Label Name" }
  let(:item) { Item.new }

  subject(:label) { described_class.new(id, name) }

  describe "#initialize" do
    it "sets the id and name correctly" do
      expect(label.id).to eq(id)
      expect(label.name).to eq(name)
    end

    it "initializes an empty array for items" do
      expect(label.items).to be_empty
    end
  end
end
