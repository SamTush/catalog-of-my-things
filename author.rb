require 'securerandom'
require_relative 'item'


class Author
  attr_accessor :first_name, :last_name, :items

  def initialize(first_name, last_name)
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    item.author = self
    @items << item
  end

  private

  def generate_id
    SecureRandom.random_number(1_000_000)
  end
end
