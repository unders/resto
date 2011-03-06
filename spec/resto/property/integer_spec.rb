# encoding: utf-8

require 'spec_helper'
require 'resto/property'

describe Resto::Property::Integer do

  context "Resto::Property::Integer.new(:age)" do
    let(:errors) { {} }
    subject { Resto::Property::Integer.new(:age) }

    context ".cast(20, errors)" do
      it("returns 20 with no errors") do
        subject.cast(20, errors).should == 20
        errors.fetch(:age_integer, false).should == nil
      end
    end

    context ".cast('22', errors)" do
      it("returns 22 with no errors") do
        subject.cast('22', errors).should == 22
        errors.fetch(:age_integer, false).should == nil
      end
    end

    context ".cast('', errors)" do
      it("returns nil with no errors") do
        subject.cast('', errors).should == nil
        errors.fetch(:age_integer, false).should == nil
      end
    end
    context ".cast('    ', errors)" do
      it("returns nil with no errors") do
        subject.cast('    ', errors).should == nil
        errors.fetch(:age_integer, false).should == nil
      end
    end

    context ".cast(nil, errors)" do
      it("returns nil with no errors") do
        subject.cast(nil, errors).should == nil
        errors.fetch(:age_integer, false).should == nil
      end
    end

    context ".cast('22q', errors)" do
      it("returns nil and sets errors[:age_integer]") do
        subject.cast('22q', errors).should == nil
        errors.fetch(:age_integer, false).should == ':age is not an integer.'
      end
    end

    context ".cast('q22', errors)" do
      it("returns nil and sets errors[:age_integer]") do
        subject.cast('q22', errors).should == nil
        errors.fetch(:age_integer, false).should == ':age is not an integer.'
      end
    end
    context ".cast('twenty', errors)" do
      it("returns nil and sets errors[:age_integer]") do
        subject.cast('twenty', errors).should == nil
        errors.fetch(:age_integer, false).should == ':age is not an integer.'
      end
    end

  end
end
