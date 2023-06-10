require 'json'
require 'date'
require_relative 'music_album'
require_relative 'genre'

MUSICS_FILE = 'music_album_file.json'.freeze
GENRES_FILE = 'genre_file.json'.freeze

# musics_data = File.exist?(MUSICS_FILE) ? JSON.parse(File.read(MUSICS_FILE)) : []
# genres_data = File.exist?(GENRES_FILE) ? JSON.parse(File.read(GENRES_FILE)) : []
musics_data = if File.exist?(MUSICS_FILE) && !File.empty?(MUSICS_FILE)
                JSON.parse(File.read(MUSICS_FILE))
              else
                []
              end

genres_data = if File.exist?(GENRES_FILE) && !File.empty?(GENRES_FILE)
                JSON.parse(File.read(GENRES_FILE))
              else
                []
              end

musics = musics_data.map do |music_data|
  MusicAlbum.new(
    music_data['id'],
    music_data['genre'],
    music_data['author'],
    music_data['source'],
    #   nil,
    Date.parse(music_data['publish_date']),
    music_data['on_spotify']
  )
end

genres = genres_data.map do |genre_data|
  genre = Genre.new(genre_data['id'], genre_data['name'])
  genre_data['items'].each do |item_id|
    item = musics.find { |music| music.id == item_id }
    item.genre = genre unless item.nil?
  end
  genre
end

loop do
  puts 'Please choose an option:'
  puts '1. List all music albums'
  puts '2. List all genres'
  puts '3. Add a music album'
  puts '4. Add genre'
  puts '5. <--- go back'

  choice = gets.chomp.to_i

  case choice
  when 1
    puts 'List of all music albums:'
    musics.each do |music|
      puts "ID: #{music.id}"
      puts "Genre: #{music.genre}"
      puts "Author: #{music.author}"
      puts "Source: #{music.source}"
      # puts "Label: #{music.label.nil? ? 'No Label' : music.label.name}"
      puts "Publish Date: #{music.publish_date}"
      puts "On Spotify: #{music.on_spotify}"
      puts '-----------------------------'
    end
  when 2
    puts 'List of all genres:'
    genres.each do |genre|
      puts genre.name
    end
  when 3
    puts 'Enter music album details:'
    puts 'ID:'
    id = gets.chomp.to_i
    puts 'Genre:'
    gets.chomp
    puts 'Author:'
    author = gets.chomp
    puts 'Source:'
    source = gets.chomp
    puts "Label Index: number between 0 to #{genres.length - 1}"
    genre_index = gets.chomp.to_i

    if genre_index.negative? || genre_index >= genres.length
      puts 'Invalid label index. Music album cannot be added.'
    else
      genre = genres[genre_index]
      puts 'Publish Date (YYYY-MM-DD):'
      publish_date = Date.parse(gets.chomp)
      puts 'On Spotify (True/False):'
      on_spotify = gets.chomp

      new_music = MusicAlbum.new(id, genre, author, source, publish_date, on_spotify)
      genre.add_item(new_music)

      # Add the new music album to the albums list
      musics << new_music

      # Save data to JSON files
      musics_data = musics.map do |music|
        {
          'id' => music.id,
          'genre' => music.genre,
          'author' => music.author,
          'source' => music.source,
          # 'label_id' => music.label.nil? ? nil : music.label.id,
          'publish_date' => music.publish_date.to_s,
          'On Spotify' => music.on_spotify
        }
      end

      genres_data = genres.map do |genre|
        {
          'id' => genre.id,
          'name' => genre.name,
          'items' => genre.items.map(&:id)
        }
      end

      File.write(MUSICS_FILE, JSON.generate(musics_data))
      File.write(GENRES_FILE, JSON.generate(genres_data))
    end
  when 4
    puts 'Enter genre details:'
    puts 'ID:'
    genre_id = gets.chomp.to_i
    puts 'Name:'
    genre_name = gets.chomp

    new_genre = Genre.new(genre_id, genre_name)
    genres << new_genre
    puts 'Genre added successfully!'

    # Save data to JSON files
    genres_data = genres.map do |genre|
      {
        'id' => genre.id,
        'name' => genre.name,
        'items' => genre.items.map(&:id)
      }
    end

    File.write(GENRES_FILE, JSON.generate(genres_data))
  when 5
    puts 'Thanks for checking Music 😘'
    # Save data to JSON files before exiting
    musics_data = musics.map do |music|
      {
        'id' => music.id,
        'genre' => music.genre,
        'author' => music.author,
        'source' => music.source,
        #   'label_id' => music.genre.nil? ? nil : music.genre.id,
        'publish_date' => music.publish_date.to_s,
        'On Spotify ' => music.on_spotify
      }
    end

    genres_data = genres.map do |genre|
      {
        'id' => genre.id,
        'name' => genre.name,
        'items' => genre.items.map(&:id)
      }
    end

    File.write(MUSICS_FILE, JSON.generate(musics_data))
    File.write(GENRES_FILE, JSON.generate(genres_data))

    require_relative 'app'
    app = App.new
    app.main_menu
  end
end
