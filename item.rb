require 'Date'
class  Item

  attr_accessor :genre, :author, :source, :label

  def initialize(id,publish_date,archive)
    @id = id
    @publish_date = publish_date
    @archive = archive
  end

  def move_to_archive()

  end

  private
  def can_be_archived?
    if Date.today << 120 > @publish_date
      return true
    end
    return false
  end
end

puts Date.today << 120