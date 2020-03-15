require 'digest'
require 'chunky_png'

class Identicon
  def initialize(user_name, path = nil, grid = 5, size = 250)
    @user_name = user_name
    @path = path
    @grid = grid
    @size = size
  end

  def generate
    init_hash
    init_color
    init_schema
    get_image
  end

  private

  def init_hash
    @hash =Digest::MD5.hexdigest(@user_name)
  end

  def init_color
    @color = "##{@hash[-6..-1]}"
  end

  def init_schema
    @schema = []
    center = @grid/2 + 1
    l = @grid - center
    @grid.times do |i|
      @schema[i] = []
      center.times do |j|
        @schema[i][j] = Integer(@hash[i*center + j], 16) % 2
      end
    end
    @grid.times do |i|
      l.times  do |j|
        @schema[i][@grid - j -1] = @schema[i][j]
      end
    end
  end

  def get_image
    size = @size / @grid
    png = ChunkyPNG::Image.new(@size, @size, ChunkyPNG::Color::TRANSPARENT)
    color = ChunkyPNG::Color.from_hex @color
    @grid.times do |i|
      @grid.times do |j|
        png.rect(j*size, i*size, (j+1)*size, (i+1)*size, color, color) if @schema[i][j] == 1
      end
    end
    png.save("#{@user_name}.png", :interlace => true)
  end
end

identicon = Identicon.new 'valov'
identicon.generate

identicon = Identicon.new 'aanna'
identicon.generate

identicon = Identicon.new 'lea'
identicon.generate