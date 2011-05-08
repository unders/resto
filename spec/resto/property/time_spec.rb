# encoding: utf-8

require 'spec_helper'
require 'resto/property'

describe Resto::Property::Time do
  let(:iso_8601_plus) { "2010-10-25T11:48:00+00:00" } # UTC
  let(:iso_8601_minus) { "2010-10-25T23:48:00-00:00" } # UTC
  let(:iso_8601_z)    { "2010-10-26T12:48:00Z" } # UTC
  let(:iso_8601_z_summer)    { "2010-05-26T12:48:00Z" } # UTC
  let(:iso_8601_cet_summer)  { "2011-05-01T14:46:00+02:00" } #GMT +2, UTC +2
  let(:iso_8601_cet_winter)  { "2011-01-01T14:46:00+01:00" } #GMT +1, UTC +1

  let(:errors) { {} }
  subject { Resto::Property::Time.new(:date_of_birth) }

  describe ".cast(time_string, errors)" do
    context "local time is 2010-10-25T12:00:00 PST" do
      it "returns a time object parsed from the string" do
        at_time("2010-10-25T12:00:00 PST", '-08:00') do #UTC -8
          time = subject.cast(iso_8601_plus, errors)
          time.iso8601.should == '2010-10-25T03:48:00-08:00'
          time.utc.iso8601.should == '2010-10-25T11:48:00Z'
          errors.fetch(:date_of_birth_time, false).should == nil
        end
      end

      it "returns a time object parsed from the string" do
        at_time("2010-10-25T12:00:00 PST", '-08:00') do #UTC -8
          time = subject.cast(iso_8601_cet_winter, errors)
          time.iso8601.should == '2011-01-01T05:46:00-08:00'
          time.utc.iso8601.should == '2011-01-01T13:46:00Z'
          errors.fetch(:date_of_birth_time, false).should == nil
        end
      end

      it "returns a time object parsed from the string" do
        at_time("2010-10-25T12:00:00 PST", '-08:00') do #UTC -8
          time = subject.cast(iso_8601_cet_summer, errors)
          time.iso8601.should == '2011-05-01T04:46:00-08:00'
          time.utc.iso8601.should == '2011-05-01T12:46:00Z'
          errors.fetch(:date_of_birth_time, false).should == nil
        end
      end

      it "returns a time object parsed from the string" do
        at_time("2010-10-25T12:00:00 PST", '-08:00') do #UTC -8
          time = subject.cast(iso_8601_z_summer, errors)
          time.localtime.iso8601.should == '2010-05-26T04:48:00-08:00'
          time.utc.iso8601.should == '2010-05-26T12:48:00Z'
          errors.fetch(:date_of_birth_time, false).should == nil
        end
      end
    end

    context ".cast('', errors)" do
      it("returns nil with no errors") do
        subject.cast('', errors).should == nil
        errors.fetch(:date_of_birth_time, false).should == nil
      end
    end
    context ".cast('    ', errors)" do
      it("returns nil with no errors") do
        subject.cast('    ', errors).should == nil
        errors.fetch(:date_of_birth_time, false).should == nil
      end
    end

    context ".cast(nil, errors)" do
      it("returns nil with no errors") do
        subject.cast(nil, errors).should == nil
        errors.fetch(:date_of_birth_time, false).should == nil
      end
    end

    context ".cast('q', errors)" do
      it("returns nil and sets errors[:date_of_birth_time]") do
        subject.cast('q', errors).should == nil
        errors.fetch(:date_of_birth_time, false).should ==
          ':date_of_birth is not a valid time format.'
      end
    end

     context ".cast('22q', errors)" do
      it("returns nil and sets errors[:date_of_birth_time]") do
        subject.cast('22q', errors).should == nil
        errors.fetch(:date_of_birth_time, false).should ==
          ':date_of_birth is not a valid time format.'
      end
    end

    context ".cast('q22', errors)" do
      it("returns nil and sets errors[:date_of_birth_time]") do
        subject.cast('q22', errors).should == nil
        errors.fetch(:date_of_birth_time, false).should ==
          ':date_of_birth is not a valid time format.'
      end
    end

    context ".cast('twenty', errors)" do
      it("returns nil and sets errors[:date_of_birth_time]") do
        subject.cast('twenty', errors).should == nil
        errors.fetch(:date_of_birth_time, false).should ==
          ':date_of_birth is not a valid time format.'
      end
    end

    context ".cast('2010-11-02T:1X', errors)" do
      it("returns nil and sets errors[:date_of_birth_time]") do
        subject.cast('2010-11-02T:1X', errors).should == nil
        errors.fetch(:date_of_birth_time, false).should ==
          ':date_of_birth is not a valid time format.'
      end
    end

    context ".cast('22/02/2010 00:00:00 UTC', errors)" do
      it("returns a time object parsed from the string") do
        time = subject.cast('22/02/2010 00:00:00 UTC', errors)
        time.utc.iso8601.should == '2010-02-22T00:00:00Z'
        errors.fetch(:date_of_birth_time, false).should == nil
      end
    end
  end
end
