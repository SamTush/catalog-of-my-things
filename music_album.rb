require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(id, genre, author, source, publish_date, on_spotify)
    super(id, genre, author, source, publish_date)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    if super()
      true
    elsif @on_spotify
      true
    else
      false
    end
  end
end