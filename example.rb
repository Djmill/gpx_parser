require 'gpx_parser'

gpx = GpxParser.GPX('gpx_test_file.gpx')
puts "*** Congrats, you just parsed your first .gpx file!"
puts "   Let's find out more about the trip..."
puts "   Trip Elevation:"
puts "     - Max Height (feet): #{gpx.elevations.max_feet}"
puts "     - Max Height (meters): #{gpx.elevations.max_meters}"
puts "     - Min Height (feet): #{gpx.elevations.min_feet}"
puts "     - Min Height (meters): #{gpx.elevations.min_meters}"
puts "     - Elevation Change (feet): #{gpx.elevations.change_feet}"
puts "     - Elevation Change (meters): #{gpx.elevations.change_meters}"
puts "   Trip Details:"
puts "     - Start Coords: #{gpx.trip_start}"
puts "     - End Coords: #{gpx.trip_end}"
