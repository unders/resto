# encoding: utf-8
require 'spec_helper'

class Article
  def initialize;               @errors = {};              end
  def title_without_cast;       " 200 ";                   end
  def empty_title_without_cast; "     ";                   end
  def errors;                   @errors;                   end
  def add_error(key, error);    @errors.store(key, error); end
end

class AProperty;
  include Resto::Property;
  def cast(value, errors); value.to_i; end
end

describe Resto::Property::Handler do
  let(:article)   { Article.new }
  let(:property)  { AProperty.new(:title) }
  let(:property2) { AProperty.new(:empty_title) }

  context "#add(property)" do
    before { subject.add(property) }

    describe "#attribute_key(property_key)" do
      it { subject.attribute_key('title').should == :title }
    end

    describe "cast(:property_key, '200', errors)" do
      it { subject.cast(:title, '200', nil).should == 200 }
    end

    describe "#attribute_key('non_existing_title')" do
      it { subject.attribute_key('non_existing_title').should == false }
    end

    context "#add(other_property)" do
      describe "#validate(article)" do
        before do
          property.validate_presence
          property2.validate_presence
          subject.add(property2)
          subject.validate(article)
        end

        context "then article has the following error" do
          it { article.errors.fetch(:title_presence, false).should == nil }

          it do
            article.errors.fetch(:empty_title_presence, false)
              .should == ":empty_title can’t be blank"
          end
        end
      end
    end
  end
end
