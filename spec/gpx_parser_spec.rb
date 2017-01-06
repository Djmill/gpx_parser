require 'spec_helper'

describe GpxParser do
  describe 'GPX parsing methods' do
    before(:each) do
      @file_path = File.dirname(__FILE__) + "/../gpx_test_file.gpx"
      @gpx_doc = Nokogiri::XML(File.read(@file_path))
    end

    describe 'GPX' do
      it 'should return a valid OpenStruct object with trip data when provided a valid file' do
        gpx = GpxParser.parse(@file_path)
        expect(gpx).to be_an(OpenStruct)
        expect(gpx.elevations.min_meters).to eq(331.454)
        expect(gpx.elevations.min_feet).to eq(1087.44754136)
        expect(gpx.elevations.max_meters).to eq(378.221)
        expect(gpx.elevations.max_feet).to eq(1240.8825856400001)
        expect(gpx.elevations.change_meters).to eq(46.766999999999996)
        expect(gpx.elevations.change_feet).to eq(153.43504428)
        expect(gpx.trip_start).to eq("40.567940, -79.908095")
        expect(gpx.trip_end).to eq("40.567963, -79.908251")
      end

      it 'should return nile when the file is not a .gpx file' do
        gpx = GpxParser.parse(File.dirname(__FILE__) + "/../example.rb")
        expect(gpx).to be_nil
      end

      it 'should nil if the file is not present' do
        gpx = GpxParser.parse(nil)
        expect(gpx).to be_nil
      end
    end

    describe 'calculate_elevations' do
      it 'should return a value hash of basic elevation data in meters' do
        elevations = GpxParser.calculate_elevations(@gpx_doc)
        expect(elevations[:min]).to be(331.454)
        expect(elevations[:max]).to be(378.221)
        expect(elevations[:elevation_change]).to be(46.766999999999996)
      end

      it 'should return nil if the input is nil' do
        elevations = GpxParser.calculate_elevations(nil)
        expect(elevations).to be_nil
      end
    end

    describe 'find_start' do
      it 'should return a string of latitude, longitude of the start of the trip' do
        start = GpxParser.find_start(@gpx_doc)
        expect(start).to eq("40.567940, -79.908095")
      end

      it 'should return nil if the input is nil' do
        start = GpxParser.find_start(nil)
        expect(start).to be_nil
      end
    end

    describe 'find_end' do
      it 'should return a string of latitude, longitude of the start of the trip' do
        trip_end = GpxParser.find_end(@gpx_doc)
        expect(trip_end).to eq("40.567963, -79.908251")
      end

      it 'should return nil if the input is nil' do
        trip_end = GpxParser.find_end(nil)
        expect(trip_end).to be_nil
      end
    end
  end

  describe 'meters_to_feet' do
    it 'should return 3.28084 if the input is 1' do
      convert = GpxParser.meters_to_feet(1)
      expect(convert).to eq(3.28084)
    end

    it 'should return nil if the input is nil' do
      convert = GpxParser.meters_to_feet(nil)
      expect(convert).to be_nil
    end
  end
end
