require 'json'
require 'date'
require_relative 'book'
require_relative 'label'

# File paths for storing data
BOOKS_FILE = 'books.json'.freeze
LABELS_FILE = 'labels.json'.freeze

# Load data from JSON files
books_data = File.exist?(BOOKS_FILE) ? JSON.parse(File.read(BOOKS_FILE)) : []
labels_data = File.exist?(LABELS_FILE) ? JSON.parse(File.read(LABELS_FILE)) : []

# Create Book and Label instances from loaded data
books = books_data.map do |book_data|
  Book.new(
    book_data['id'],
    book_data['genre'],
    book_data['author'],
    book_data['source'],
    nil,
    Date.parse(book_data['publish_date']),
    book_data['publisher'],
    book_data['cover_state']
  )
end

labels = labels_data.map do |label_data|
  label = Label.new(label_data['id'], label_data['name'])
  label_data['items'].each do |item_id|
    item = books.find { |book| book.id == item_id }
    item.label = label unless item.nil?
  end
  label
end

# Main program loop
loop do
  puts 'Please choose an option:'
  puts '1. List all books'
  puts '2. List all labels'
  puts '3. Add a book'
  puts '4. Add labels'
  puts '5. <-- Go back'

  choice = gets.chomp.to_i

  case choice
  when 1
    puts 'List of all books:'
    books.each do |book|
      puts "ID: #{book.id}"
      puts "Genre: #{book.genre}"
      puts "Author: #{book.author}"
      puts "Source: #{book.source}"
      puts "Label: #{book.label.nil? ? 'No Label' : book.label.name}"
      puts "Publish Date: #{book.publish_date}"
      puts "Publisher: #{book.publisher}"
      puts "Cover State: #{book.cover_state}"
      puts "Archived: #{book.archived}"
      puts '-----------------------------'
    end
  when 2
    puts 'List of all labels:'
    labels.each do |label|
      puts label.name
    end
  when 3
    puts 'Enter book details:'
    puts 'ID:'
    id = gets.chomp.to_i
    puts 'Genre:'
    genre = gets.chomp
    puts 'Author:'
    author = gets.chomp
    puts 'Source:'
    source = gets.chomp
    puts "Label Index: number between 0 to #{labels.length - 1}"
    label_index = gets.chomp.to_i

    if label_index.negative? || label_index >= labels.length
      puts 'Invalid label index. Book cannot be added.'
    else
      selected_label = labels[label_index]
      puts 'Publish Date (YYYY-MM-DD):'
      publish_date = Date.parse(gets.chomp)
      puts 'Publisher:'
      publisher = gets.chomp
      puts 'Cover State (good/bad):'
      cover_state = gets.chomp

      new_book = Book.new(id, genre, author, source, selected_label, publish_date, publisher, cover_state)
      selected_label.add_item(new_book)
      puts 'Book added successfully!'

      # Add the new book to the books list
      books << new_book

      # Save data to JSON files
      books_data = books.map do |book|
        {
          'id' => book.id,
          'genre' => book.genre,
          'author' => book.author,
          'source' => book.source,
          'label_id' => book.label&.id,
          'publish_date' => book.publish_date.to_s,
          'publisher' => book.publisher,
          'cover_state' => book.cover_state
        }
      end

      labels_data = labels.map do |lbl|
        {
          'id' => lbl.id,
          'name' => lbl.name,
          'items' => lbl.items.map(&:id)
        }
      end

      File.write(BOOKS_FILE, JSON.generate(books_data))
      File.write(LABELS_FILE, JSON.generate(labels_data))
    end
  when 4
    puts 'Enter label details:'
    puts 'ID:'
    label_id = gets.chomp.to_i
    puts 'Name:'
    label_name = gets.chomp

    new_label = Label.new(label_id, label_name)
    labels << new_label
    puts 'Label added successfully!'

    # Save data to JSON files
    labels_data = labels.map do |lbl|
      {
        'id' => lbl.id,
        'name' => lbl.name,
        'items' => lbl.items.map(&:id)
      }
    end

    File.write(LABELS_FILE, JSON.generate(labels_data))
  when 5
    puts 'Going back the program...'
    # Save data to JSON files before exiting
    books_data = books.map do |book|
      {
        'id' => book.id,
        'genre' => book.genre,
        'author' => book.author,
        'source' => book.source,
        'label_id' => book.label&.id,
        'publish_date' => book.publish_date.to_s,
        'publisher' => book.publisher,
        'cover_state' => book.cover_state
      }
    end

    labels_data = labels.map do |lbl|
      {
        'id' => lbl.id,
        'name' => lbl.name,
        'items' => lbl.items.map(&:id)
      }
    end

    File.write(BOOKS_FILE, JSON.generate(books_data))
    File.write(LABELS_FILE, JSON.generate(labels_data))
    require_relative 'app'
    app = App.new
    app.main_menu
  end
end
