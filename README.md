# GpxParser

GpxParser is a gem that provides a quick way to turn .gpx files into a useful object. This gem leverages Nokogiri for parsing.

## Installation

To install and use this gem locally for now, please run
```
rake install
```
From the gem's root directory on your machine.

Next, add the following line to your Gemfile if you're using Rails.

```ruby
gem 'gpx_parser'
```

And then execute:

    $ bundle

Otherwise, add the following line to your script if you're running this with plain Ruby:

```ruby
require 'gpx_parser'
```


## Usage

Simply pass a valid .gpx file path to the GpxParser::GPX method:

```ruby
gpx = GpxParser.GPX('gpx_test_file.gpx')
```

Now you can find out some useful info about the trip:
#### Minimum Elevation (in meters)
gpx.elevations.min_meters
  => 331.454

#### Maximum Elevation (in meters)
gpx.elevations.max_meters
  => 378.221

#### Minimum Elevation (in feet)
gpx.elevations.min_feet
  => 1087.44754136

#### Maximum Elevation (in feet)
gpx.elevations.max_feet
  => 1240.8825856400001

#### Elevation Change (in meters)
gpx.elevations.change_meters
  => 46.766999999999996

#### Elevation Change (in feet)
gpx.elevations.change_feet
  => 153.43504428

#### Trip Start Coordinates
gpx.trip_start
  => "40.567940, -79.908095"

#### Trip End Coordinates
gpx.trip_end
  => "40.567963, -79.908251"

## Example script:

For an example, try installing the gem locally and running the example.rb file.

To run the example file, simply execute:

```
ruby example.rb
```
within the gem's root directory from your terminal/console.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

