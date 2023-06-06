require 'Date'
class Item
  attr_accessor :genre, :author, :source, :label

  def initialize(id, publish_date, archive: false)
    @id = id
    @publish_date = publish_date
    @archive = archive
  end

  def move_to_archive()
    @archive = true if can_be_archived?
  end

  private

  def can_be_archived?
    return true if Date.today << 120 > @publish_date

    false
  end
end
