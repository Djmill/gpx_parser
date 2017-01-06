require 'gpx_parser'

gpx = GpxParser.parse('gpx_test_file.gpx')
puts "*** Congrats, you just parsed your first .gpx file!"
puts "   Let's find out more about the trip..."
puts "   Trip Elevation:"
puts "     - Max Height (feet): #{gpx.elevations.max.feet}"
puts "     - Max Height (meters): #{gpx.elevations.max.meters}"
puts "     - Min Height (feet): #{gpx.elevations.min.feet}"
puts "     - Min Height (meters): #{gpx.elevations.min.meters}"
puts "     - Elevation Change (feet): #{gpx.elevations.change.feet}"
puts "     - Elevation Change (meters): #{gpx.elevations.change.meters}"
puts "   Trip Details:"
puts "     - Start Coords: #{gpx.trip_start}"
puts "     - End Coords: #{gpx.trip_end}"
