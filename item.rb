require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :id, :archive

  def initialize(id,publish_date, archive: false)
    raise ArgumentError, "Invalid publish_date" unless publish_date.is_a?(Date)

    @publish_date = publish_date
    @archive = archive
    @id = id
  end

  def move_to_archive
    @archive = true if can_be_archived?
  end

  private

  def can_be_archived?
    Date.today << 120 > @publish_date
  end
end
