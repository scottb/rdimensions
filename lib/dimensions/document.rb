module Dimensions
  class Document
    include MDMObject
    include LabeledObject

    attr_accessor :xml

    def self.mdm_version
      '5.0.3.3066'
    end

    attr_reader :categories
    attr_reader :category_map
    attr_reader :languages
    attr_reader :data_sources
    attr_reader :contexts
    attr_reader :label_types
    attr_reader :routing_contexts
    attr_reader :fields
    attr_reader :variables
    attr_reader :variable_instances
    attr_reader :created_by_version
    attr_reader :last_updated_by_version

    def document
      self
    end

    def parent
      nil
    end

    def url
      @xml.url
    end

    def name_prefix
      ''
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

private
    def self.get_type( type)
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
  end
end
