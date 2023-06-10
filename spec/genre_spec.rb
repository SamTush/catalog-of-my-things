require 'rspec'
require_relative '../genre'
require_relative '../music_album'

describe Genre do
  let(:genre) { Genre.new(1, 'Rock') }
  let(:music_album) { MusicAlbum.new(1, 'Rock', 'Artist', 'Source', '2023-06-09', true) }

  describe '#initialize' do
    it 'sets the attributes correctly' do
      expect(genre.id).to eq(1)
      expect(genre.name).to eq('Rock')
      expect(genre.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'adds the item to the genre' do
      genre.add_item(music_album)
      expect(genre.items).to include(music_album)
      expect(music_album.genre).to eq(genre)
    end
  end
end
