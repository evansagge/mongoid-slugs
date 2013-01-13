module Mongoid::Slugs
  extend ActiveSupport::Concern

  included do
    field :slug, type: String

    index({ slug: -1 }, { unique: true })

    before_save :generate_slug
  end

  module ClassMethods
    def slug_on(field)
      @@slug_field ||= {}
      @@slug_field[self.name] = field.to_sym
    end

    def slug_field
      @@slug_field ||= {}
      @@slug_field[self.name]
    end

    def find_by_slug(slug)
      find_by(slug: slug)
    end
  end

  def to_param
    slug
  end

  protected

  def generate_slug
    raise Mongoid::Sluggable::Errors::UndefinedField.new(self.class) if self.class.slug_field.blank?
    raise Mongoid::Sluggable::Errors::UnrecognizedField.new(self.class, self.class.slug_field) unless self.class.fields.has_key?(self.class.slug_field.to_s)

    base_slug = send(self.class.slug_field).parameterize

    pattern = /^#{Regexp.escape(base_slug)}(?:-(\d{1,2}))?$/
    existing_slugs = self.class.where(slug: pattern).ne(_id: _id).only(:slug).map(&:slug)
    if existing_slugs.any?
      max_counter = existing_slugs.map { |s| (pattern.match(s)[1] || 0 ).to_i }.max
      base_slug << "-#{max_counter + 1}"
    end

    self.slug = base_slug
  end

  module Errors
    class UndefinedField < Mongoid::Errors::MongoidError
      def initialize(klass)
        super "Sluggable field needs to be defined on #{klass.name} using :slug_on"
      end
    end

    class UnrecognizedField < Mongoid::Errors::MongoidError
      def initialize(klass, field)
        super "#{klass.name} needs to have #{field.to_sym} defined as a field to create a slug from it"
      end
    end
  end

end