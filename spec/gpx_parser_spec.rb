require 'spec_helper'

describe GpxParser do
  describe 'GPX parsing methods' do
    before(:each) do
      @file_path = File.dirname(__FILE__) + "/../gpx_test_file.gpx"
    end

    describe 'GPX' do
      it 'should return a valid OpenStruct object with trip data when provided a valid file' do
        gpx = GpxParser.parse(@file_path)
        expect(gpx).to be_an(GpxParser::GpxDoc)
        expect(gpx.elevations.min.meters).to eq(331.454)
        expect(gpx.elevations.min.feet).to eq(1087.44754136)
        expect(gpx.elevations.max.meters).to eq(378.221)
        expect(gpx.elevations.max.feet).to eq(1240.8825856400001)
        expect(gpx.elevations.change.meters).to eq(46.766999999999996)
        expect(gpx.elevations.change.feet).to eq(153.43504428)
        expect(gpx.trail_start).to eq("40.567940, -79.908095")
        expect(gpx.trail_end).to eq("40.567963, -79.908251")
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

    describe 'GpxDoc' do
      before(:each) do
        @gpx_doc = GpxParser::GpxDoc.new(@file_path)
      end

      describe 'calculate_elevations' do
        before(:each) do
          @gpx_doc.elevations = nil
        end

        it 'should set the GpxDoc elevations variable' do
          @gpx_doc.calculate_elevations
          expect(@gpx_doc.elevations.min.meters).to be(331.454)
          expect(@gpx_doc.elevations.max.meters).to be(378.221)
          expect(@gpx_doc.elevations.change.meters).to be(46.766999999999996)
        end

        it 'should not set elevations if self.gpx_doc is nil' do
          @gpx_doc.gpx_doc = nil
          @gpx_doc.calculate_elevations
          expect(@gpx_doc.elevations).to be_nil
        end
      end

      describe 'set_start_coords' do
        before(:each) do
          @gpx_doc.trail_start = nil
        end

        it 'should set trail_start as a string of: latitude, longitude' do
          @gpx_doc.set_start_coords
          expect(@gpx_doc.trail_start).to eq("40.567940, -79.908095")
        end

        it 'should not set trail_start if gpx_doc is nil' do
          @gpx_doc.gpx_doc = nil
          @gpx_doc.set_start_coords
          expect(@gpx_doc.trail_start).to be_nil
        end
      end

      describe 'set_end_coords' do
        before(:each) do
          @gpx_doc.trail_end = nil
        end

        it 'should set trail_end as a string of latitude, longitude' do
          @gpx_doc.set_end_coords
          expect(@gpx_doc.trail_end).to eq("40.567963, -79.908251")
        end

        it 'should not set trail_end if gpx_doc is nil' do
          @gpx_doc.gpx_doc = nil
          @gpx_doc.set_end_coords
          expect(@gpx_doc.trail_end).to be_nil
        end
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
