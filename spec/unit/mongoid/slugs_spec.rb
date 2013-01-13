require 'spec_helper'

describe Mongoid::Slugs do
  before do
    class TestClass
      include Mongoid::Document
      include Mongoid::Slugs

      field :title
    end
  end

  describe "sluggable model" do
    it "has a :slug field" do
      expect(TestClass.fields).to have_key("slug")
      expect(TestClass.fields["slug"].options[:type]).to eq String
    end

    describe ".slug_on" do
      before do
        TestClass.slug_on :title
      end

      it "sets the .slug_field" do
        expect(TestClass.slug_field).to eq :title
      end
    end
  end

  describe "sluggable object" do
    before do
      TestClass.slug_on :title
    end

    let!(:sluggable_object) do
      TestClass.new(title: "This is a test slug")
    end

    describe "#save" do
      before do
        sluggable_object.save
      end

      it "sets the slug" do
        expect(sluggable_object.slug).to eq "this-is-a-test-slug"
      end
    end
  end
end