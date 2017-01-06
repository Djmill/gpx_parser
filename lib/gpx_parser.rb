require "gpx_parser/version"
require "nokogiri"
require "ostruct"

module GpxParser
  TRKPT = "//xmlns:trkpt"
  ELE = "//xmlns:ele"

  def self.calculate_elevations(gpx_doc)
    if !gpx_doc.nil?
      min, max, change = 0, 0, nil
      gpx_doc.xpath(GpxParser::ELE).children.each_with_index do |ele, i|
        elevation = ele.content.to_f
        if i == 0
          min, max = elevation, elevation
        elsif elevation > max
          max = elevation
        elsif elevation < min
          min = elevation
        end
      end
      change = max - min
      {min: min, max: max, elevation_change: change}
    end
  end

  def self.find_start(gpx_doc)
    if !gpx_doc.nil?
      first_attr = gpx_doc.xpath(GpxParser::TRKPT)[0].attributes
      "#{first_attr['lat'].value}, #{first_attr['lon'].value}"
    end
  end

  def self.find_end(gpx_doc)
    if !gpx_doc.nil?
      trkpts = gpx_doc.xpath(GpxParser::TRKPT)
      last_attr = trkpts[(trkpts.length - 1)].attributes
      "#{last_attr['lat'].value}, #{last_attr['lon'].value}"
    end
  end

  def self.meters_to_feet(num)
    num * 3.28084 if !num.nil?
  end

  def self.parse(file_path)
    if !file_path.nil? && file_path.include?(".gpx")
      trip = {}
      gpx_doc = Nokogiri::XML(File.read(file_path))
      trip[:elevations] = calculate_elevations(gpx_doc)
      OpenStruct.new(
        elevations: OpenStruct.new(
                      min_meters: trip[:elevations][:min],
                      max_meters: trip[:elevations][:max],
                      min_feet: meters_to_feet(trip[:elevations][:min]),
                      max_feet: meters_to_feet(trip[:elevations][:max]),
                      change_meters: trip[:elevations][:elevation_change],
                      change_feet: meters_to_feet(trip[:elevations][:elevation_change])
                    ),
        trip_start: find_start(gpx_doc),
        trip_end: find_end(gpx_doc)
      )
    end
  end
end
