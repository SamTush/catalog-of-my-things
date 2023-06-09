require_relative 'game'
require_relative 'game_collection'
require 'json'


class App
  def main_menu
    puts 'Hey Welcome to Our catalog'
    options = [
      '1 - Books',
      '2 - Music albums ',
      '3 - Games',
      '4 - Quit'
    ]
    puts options
    option = gets.chomp.downcase
    case option
    when '1'
      # book = BookMethods.new('./data/books.json')
      # book.run
      require_relative 'book-collection'

    when '2'
      # album = MusicAlbumDisplay.new('./data/albums.json')
      # album.run
      require_relative 'music_album_collection'
    when '3'
      game = GameStore.new
      game.run

    when '4'
      puts 'Thanks for spending sometime in our catalog '
      nil
    else
      puts 'oops it seems something went wrong, Please try again.'
      main_menu
    end
  end
end

app = App.new
app.main_menu
