class Item
  attr_accessor :id, :genre, :author, :source, :label, :publish_date, :archived

  def initialize(id = Random.rand(1..1000), genre = 'nil', author = '', source = '', label = 1,
                 publish_date = '2000-2-2')
    @id = id
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def lable=(lable)
    @lable = lable
    lable.items.push(self) unless lable.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  private

  def can_be_archived?
    begin
      publish_date = Date.parse(@publish_date)
    rescue StandardError
      publish_date = nil
    end
    if publish_date.nil?
      false
    else
      (Date.today.year - publish_date.year) > 10
    end
  end
end
