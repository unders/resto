# encoding: utf-8
require 'spec_helper'

class Article
  def initialize;               @errors = {};              end
  def title_without_cast;       " 200 ";                   end
  def empty_title_without_cast; "     ";                   end
  def errors;                   @errors;                   end
  def add_error(key, error);    @errors.store(key, error); end
end

class AProperty; include Resto::Property; end

describe Resto::Property do
  let(:article) { Article.new }

  context "AProperty.new(:title, :remote_name => :a_very_bad__title_name)" do
    subject { AProperty.new(:title, :remote_name => :a_very_bad__title_name) }

    its(:remote_key) { should == 'a_very_bad__title_name' }
    its(:attribute_key) { should == :title }
    its(:attribute_key_as_string) { should == 'title' }

    context "when #validate_presence is called" do
      before { subject.validate_presence }

      describe "#validate(article, :title)" do
        context "then article.errors" do

          before { subject.validate(article, :title)  }

          it { article.errors[:title_presence].should == nil }
        end
      end
    end
  end

  context "AProperty.new(:empty_title)" do
    subject { AProperty.new(:empty_title) }

    its(:remote_key) { should == 'empty_title' }
    its(:attribute_key) { should == :empty_title }
    its(:attribute_key_as_string) { should == 'empty_title' }

    context "when #validate_presence is called" do
      before { subject.validate_presence }

      describe "#validate(article, :empty_title)" do
        context "then article.errors" do
          before { subject.validate(article, :empty_title)  }

          it {
            article.errors[:empty_title_presence]
              .should == ":empty_title can’t be blank"
          }
        end
      end
    end
  end
end
