# encoding: utf-8
require 'spec_helper'

class Article
  def initialize;               @errors = {};              end
  def title_without_cast;       " 200 ";                   end
  def empty_title_without_cast; "  ";                      end
  def nil_title_without_cast;                              end

  def errors;                   @errors;                   end
  def add_error(key, error);    @errors.store(key, error); end

  def false;                    false;                     end
  def true;                     true;                      end
end

describe Resto::Validate::Presence do
  let(:article) { Article.new }

  context "Resto::Validate::Presence.new" do
    let(:validate) { Resto::Validate::Presence.new }

    before do
      validate.attribute_value(article, :title)
      validate.attribute_value(article, :empty_title)
      validate.attribute_value(article, :nil_title)
    end

    context "errors" do
      let(:errors) { article.errors }

      it { errors[:title_presence].should == nil }
      it {
        errors[:empty_title_presence].should == ":empty_title can’t be blank"
      }
      it { errors[:nil_title_presence].should == ":nil_title can’t be blank" }
    end
  end


  context "Resto::Validate::Presence.new .message 'must have a value' " do
    let(:validate) { Resto::Validate::Presence.new.message 'must have a value' }

    before do
      validate.attribute_value(article, :title)
      validate.attribute_value(article, :empty_title)
      validate.attribute_value(article, :nil_title)
    end

    context "errors" do
      let(:errors) { article.errors }

      it { errors[:title_presence].should == nil }
      it {
        errors[:empty_title_presence].should == ":empty_title must have a value"
      }
      it {
        errors[:nil_title_presence].should == ":nil_title must have a value"
      }
    end
  end

  context "Resto::Validate::Presence.new .if { |resource| resource.false }" do
    let(:validate) do
      Resto::Validate::Presence.new .if { |article| article.false }
    end

    before do
      validate.attribute_value(article, :title)
      validate.attribute_value(article, :empty_title)
      validate.attribute_value(article, :nil_title)
    end

    context "errors" do
      let(:errors) { article.errors }

      it { errors[:title_presence].should == nil }
      it { errors[:empty_title_presence].should == nil }
      it { errors[:nil_title_presence].should == nil }
    end
  end

  context "Resto::Validate::Presence.new.unless { |resource| resource.true }" do
    let(:validate) do
      Resto::Validate::Presence.new .unless { |article| article.true }
    end

    before do
      validate.attribute_value(article, :title)
      validate.attribute_value(article, :empty_title)
      validate.attribute_value(article, :nil_title)
    end

    context "errors" do
      let(:errors) { article.errors }

      it { errors[:title_presence].should == nil }
      it { errors[:empty_title_presence].should == nil }
      it { errors[:nil_title_presence].should == nil }
    end
  end
end
