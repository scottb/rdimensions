module Dimensions
  class Document
    include MDMObject
    include LabeledObject

    attr_accessor :xml
    attr_reader :node, :uuids
    def vdef( name) @defined_variables.find {|v| v.name == name } end

    def self.mdm_version
      '5.0.3.3066'
    end

    attr_reader :category_map
    attr_reader :languages
    attr_reader :data_sources
    attr_reader :contexts
    attr_reader :label_types
    attr_reader :routing_contexts
    attr_reader :fields
    attr_reader :created_by_version
    attr_reader :last_updated_by_version

    def document
      self
    end

    def url
      @xml.url
    end

    def log_action
      raise NotYetImplementedException
    end
    alias valid? log_action
    alias valid_version? log_action
    alias join log_action
    alias join_conflicts log_action
    alias data_source_properties log_action

    def inspect
      "#<#{self.class}:#{object_id}>"
    end
    alias to_s inspect

private
    def self.map_object_type_value( node_name)
      case node_name
      when 'variable'
	:variable
      when 'loop'
	:array
      when 'class'
	:class
      when 'metadata'
	:document
      else
	raise NotYetImplementedException, "type: #{node_name}"
      end
    end
  end
end
