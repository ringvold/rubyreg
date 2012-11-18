module ActiveModel
  module Naming
    # Returns an ActiveModel::Name object for module. It can be
    # used to retrieve all kinds of naming-related information.
    def model_name
      @_model_name ||= begin
        namespace = self.parents.detect do |n|
          n.respond_to?(:use_relative_model_naming?) && n.use_relative_model_naming?
        end
        ActiveModel::Name.new(self, namespace, "reply")
      end
    end

    # Returns the plural class name of a record or class. Examples:
    #
    #   ActiveModel::Naming.plural(post)             # => "posts"
    #   ActiveModel::Naming.plural(Highrise::Person) # => "highrise_people"
    def self.plural(record_or_class)
      model_name_from_record_or_class(record_or_class).plural
    end

    # Returns the singular class name of a record or class. Examples:
    #
    #   ActiveModel::Naming.singular(post)             # => "post"
    #   ActiveModel::Naming.singular(Highrise::Person) # => "highrise_person"
    def self.singular(record_or_class)
      model_name_from_record_or_class(record_or_class).singular
    end

    # Identifies whether the class name of a record or class is uncountable. Examples:
    #
    #   ActiveModel::Naming.uncountable?(Sheep) # => true
    #   ActiveModel::Naming.uncountable?(Post) => false
    def self.uncountable?(record_or_class)
      plural(record_or_class) == singular(record_or_class)
    end

    # Returns string to use while generating route names. It differs for
    # namespaced models regarding whether it's inside isolated engine.
    #
    # For isolated engine:
    # ActiveModel::Naming.route_key(Blog::Post) #=> post
    #
    # For shared engine:
    # ActiveModel::Naming.route_key(Blog::Post) #=> blog_post
    def self.singular_route_key(record_or_class)
      model_name_from_record_or_class(record_or_class).singular_route_key
    end

    # Returns string to use while generating route names. It differs for
    # namespaced models regarding whether it's inside isolated engine.
    #
    # For isolated engine:
    # ActiveModel::Naming.route_key(Blog::Post) #=> posts
    #
    # For shared engine:
    # ActiveModel::Naming.route_key(Blog::Post) #=> blog_posts
    #
    # The route key also considers if the noun is uncountable and, in
    # such cases, automatically appends _index.
    def self.route_key(record_or_class)
      model_name_from_record_or_class(record_or_class).route_key
    end

    # Returns string to use for params names. It differs for
    # namespaced models regarding whether it's inside isolated engine.
    #
    # For isolated engine:
    # ActiveModel::Naming.param_key(Blog::Post) #=> post
    #
    # For shared engine:
    # ActiveModel::Naming.param_key(Blog::Post) #=> blog_post
    def self.param_key(record_or_class)
      model_name_from_record_or_class(record_or_class).param_key
    end

    private
      def self.model_name_from_record_or_class(record_or_class)
        (record_or_class.is_a?(Class) ? record_or_class : convert_to_model(record_or_class).class).model_name
      end

      def self.convert_to_model(object)
        object.respond_to?(:to_model) ? object.to_model : object
      end
  end

end