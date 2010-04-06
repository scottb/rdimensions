module Dimensions
  class Document
    include MDMObject
    include LabeledObject

    def self.mdm_version
      '5.0.3.3066'
    end

    attr_reader :xml
    attr_reader :categories, :category_map, :languages, :data_sources, :contexts
    attr_reader :label_types, :routing_contexts, :fields, :variables
    attr_reader :created_by_version, :last_updated_by_version
    attr_writer :default_label_context, :default_label_language

    def initialize
    end

    def default_label_context
      @default_label_context || :question
    end

    def default_label_language
      @default_label_language || @languages_base || 'en-US'
    end

    def document
      self
    end

    def parent
    end

    def url
      @xml.url
    end

    def variable_instances
      @variable_instances ||= build_variable_instances
    end

    def self.make_instance_name( full_name, *indexes)
      indexes = indexes.dup
      while !indexes.empty? && full_name =~ /\.\./
	full_name = $` + indexes.shift + $'
      end
      full_name
    end

    def log_action
      raise NotYetImplementedException
    end
    alias valid? log_action
    alias valid_version? log_action
    alias join log_action
    alias join_conflicts log_action
    alias data_source_properties log_action
    alias pages log_action

    def inspect
      "#<#{self.class}:#{object_id}>"
    end
    alias to_s inspect

    class << self
      def get_type( type)
	case type
	  when 0
	    :none
	  when 1
	    :integer
	  when 2
	    :text
	  when 3
	    :category
	  when 4
	    :object
	  when 5
	    :date
	  when 6
	    :double
	  when 7
	    :boolean
	  when 8
	    :level
	  else
	    type
	end
      end

      def sum( collection, identity = 0, &block)
	return identity unless collection.size > 0
	collection.inject( identity) {|sum, element| sum + element }
      end
    end
  end
end
