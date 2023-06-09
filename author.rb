require 'securerandom'
require_relative 'item'

class Author < Item
  attr_reader :id, :first_name, :last_name, :items

  def initialize(first_name, last_name, _items = [])
    super()
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def self.json_create(object)
    new(object['first_name'], object['last_name'], object['items'])
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.add_author(self)
  end

  def to_hash
    {
      id: @id,
      first_name: @first_name,
      last_name: @last_name,
      items: @items.map(&:to_hash)
    }
  end

  private

  def generate_id
    SecureRandom.random_number(1_000_000)
  end
end
