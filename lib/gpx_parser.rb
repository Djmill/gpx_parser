require "gpx_parser/version"
require "nokogiri"
require "ostruct"

module GpxParser
  TRKPT = "//xmlns:trkpt"
  ELE = "//xmlns:ele"
  M_TO_F = 3.28084

  class GpxDoc
    attr_accessor :elevations
    attr_accessor :trail_start
    attr_accessor :trail_end

    def initialize(filepath, **options)
      self.gpx_doc = Nokogiri::XML(File.read(file_path))
      self.options = options
      gpx_doc.calculate_elevations(gpx_doc)
      gpx_doc.set_start_coords
      gpx_doc.set_end_coords
    end

    def calculate_elevations
      if !gpx_doc.nil?
        min, max, change = 0, 0, nil
        self.gpx_doc.xpath(GpxParser::ELE).children.each_with_index do |ele, i|
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
        elevations = {min: min, max: max, elevation_change: change}
        set_elevations(elevations)
      end
    end

    def self.set_elevations(elevations)
      self.elevations = OpenStruct.new(
        change: OpenStruct.new(
          feet: GpxParser.meters_to_feet(elevations[:elevations][:elevation_change]),
          meters: elevations[:elevations][:elevation_change]
        ),
        max:  OpenStruct.new(
          feet: GpxParser.meters_to_feet(elevations[:elevations][:max]),
          meters: elevations[:elevations][:max]
        ),
        min:  OpenStruct.new(
          feet: GpxParser.meters_to_feet(elevations[:elevations][:min]),
          meters: elevations[:elevations][:min]
        )
      )
    end

    def self.set_start_coords
      if !self.gpx_doc.nil?
        first_attr = self.gpx_doc.xpath(GpxParser::TRKPT)[0].attributes
        self.trail_start = "#{first_attr['lat'].value}, #{first_attr['lon'].value}"
      end
    end

    def self.set_end_coords
      if !self.gpx_doc.nil?
        trkpts = self.gpx_doc.xpath(GpxParser::TRKPT)
        last_attr = trkpts[(trkpts.length - 1)].attributes
        self.trail_end = "#{last_attr['lat'].value}, #{last_attr['lon'].value}"
      end
    end
  end

  def self.meters_to_feet(num)
    num * GpxParser::M_TO_F if !num.nil?
  end

  def self.parse(file_path)
    if !file_path.nil? && file_path.include?(".gpx")
      gpx_doc = GpxParser::GpxDoc.new(file_path)
    end
  end
end
