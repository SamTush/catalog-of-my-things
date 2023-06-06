require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :title, :platform, :last_played_at

  def initialize(id, publish_date, title, platform, last_played_at, archive: false)
    super(id, publish_date, archive: archive)
    @title = title
    @platform = platform
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && @last_played_at < Date.today - 2*365
  end
end

