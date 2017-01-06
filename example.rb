require 'gpx_parser'

gpx = GpxParser.parse('gpx_test_file.gpx')

print <<"EOF";
*** Congrats, you just parsed your first .gpx file!
  Let's find out more about the trip...
    Trip Elevation:
      - Max Height (feet): #{gpx.elevations.max.feet}
      - Max Height (meters): #{gpx.elevations.max.meters}
      - Min Height (feet): #{gpx.elevations.min.feet}
       - Min Height (meters): #{gpx.elevations.min.meters}
      - Elevation Change (feet): #{gpx.elevations.change.feet}
      - Elevation Change (meters): #{gpx.elevations.change.meters}
    Trip Details:
      - Start Coords: #{gpx.trail_start}
      - End Coords: #{gpx.trail_end}
EOF
