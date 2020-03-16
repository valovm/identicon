require 'digest'
require 'chunky_png'

class Identicon

  DEFAULT_OPTIONS = {
      cell_size: 50,
      grid: 5,
      background: '#cccccc'
  }

  def initialize(user_name, path = nil, options = {})
    @user_name = user_name
    @path = path
    @options = DEFAULT_OPTIONS.merge(options)
    validate
  end

  def generate
    init_hash
    init_color
    init_schema
    get_image
  end

  private

  def validate
    raise 'user_name cannot be nil' if @user_name.nil? || @user_name.empty?
    raise 'grid must be between 4 and 12' unless (4..12).include?(@options[:grid])
    raise 'invalid cell size' unless @options[:cell_size] > 0
    raise 'folder is not exist' unless @path.nil? || File.directory?(@path)
  end

  def init_hash
    @hash =Digest::MD5.hexdigest(@user_name)
  end

  def init_color
    @color = "##{@hash[-6..-1]}"
  end

  def init_schema
    @schema = [], grid = @options[:grid]
    center = grid%2 == 0 ? grid/2 : grid/2 + 1
    l = grid - center

    grid.times do |i|
      @schema[i] = []
      center.times { |j| @schema[i][j] = Integer(@hash[i*center + j], 16) % 2 }
      l.times  { |j| @schema[i][grid - j -1] = @schema[i][j] }
    end
  end

  def get_image
    grid = @options[:grid]
    size = @options[:cell_size]
    bg = @options[:background] ? ChunkyPNG::Color.from_hex(@options[:background]) : ChunkyPNG::Color::TRANSPARENT
    image_size = grid * size
    png = ChunkyPNG::Image.new image_size, image_size, bg
    color = ChunkyPNG::Color.from_hex @color
    grid.times do |i|
      grid.times do |j|
        png.rect(j*size, i*size, (j+1)*size, (i+1)*size, color, color) if @schema[i][j] == 1
      end
    end

    png.save("#{@path}/#{@user_name}.png", :interlace => true)
  end
end
