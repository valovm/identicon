require 'helpers'

describe Identicon do

  test_folder = 'test_files'

  around(:all) do |example|
    Dir.mkdir(test_folder) unless File.directory?(test_folder)
    example.run
    FileUtils.rm_rf(test_folder)
  end

  it 'unvalid' do
    lambda { Identicon.new('valovm', nil,  grid: 2) }.should raise_exception('grid must be between 4 and 12')
    lambda { Identicon.new('') }.should raise_exception('user_name cannot be nil')
    lambda { Identicon.new('valovm', nil, cell_size: 0) }.should raise_exception('invalid cell size')
    lambda { Identicon.new('valovm', 'nil') }.should raise_exception('folder is not exist')
  end

  it 'creates a identicon\' image ' do
    identicon = Identicon.new('valov', test_folder)
    identicon.generate
    result = File.exist?("#{test_folder}/valov.png")
    expect(result).to be_truthy
  end
end
