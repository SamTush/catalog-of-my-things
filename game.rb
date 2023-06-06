require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :last_played_at, :multiplayer

  def initialize(id, publish_date, last_played_at, multiplayer,archive: false)
    super(id, publish_date, archive: archive)
    @multiplayer  =multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && @last_played_at < Date.today - 2*365
  end
end

