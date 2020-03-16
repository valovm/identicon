# Identicon

## Usage
```ruby
icon = Identicon.new <user_name>, <path>, <options>
icon.generate
```
    user_name - string, require
    path - string, optional, default value: current folder
    options - hash, optional, 

## Options

You can pass options to customize

    background: (String, default '#ccc') the background color
    grid:       (Integer, default 5, range 4..12) - the number of rows and collumns for grid
    cell_size:  (Integer, default 50)  - size of grid's cells in pixels


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

