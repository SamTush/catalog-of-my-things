require 'rspec'
require_relative '../music_album'

describe MusicAlbum do
  let(:genre) { "Rock" }
  let(:author) { "Band X" }
  let(:label) { "Record Label Y" }
  let(:publish_date) { "2022-01-01" }
  let(:on_spotify) { true }

  subject(:album) { described_class.new(genre, author, label, publish_date, on_spotify) }

  describe "#initialize" do
    it "sets the attributes correctly" do
      expect(album.genre).to eq(genre)
      expect(album.author).to eq(author)
      expect(album.label).to eq(label)
      expect(album.publish_date).to eq(publish_date)
      expect(album.on_spotify).to eq(on_spotify)
    end

    it "inherits from Item and sets the publish_date" do
      expect(album.publish_date).to eq(publish_date)
    end
  end

  describe ".from_json" do
    it "returns a MusicAlbum instance from a JSON string" do
      json = {
        genre: genre,
        author: author,
        label: label,
        publish_date: publish_date,
        on_spotify: on_spotify
      }.to_json

      parsed_album = described_class.from_json(json)

      expect(parsed_album.genre).to eq(genre)
      expect(parsed_album.author).to eq(author)
      expect(parsed_album.label).to eq(label)
      expect(parsed_album.publish_date).to eq(publish_date)
      expect(parsed_album.on_spotify).to eq(on_spotify)
    end
  end
end