require 'nokogiri'
require 'dimensions/xpath_helper'
require 'dimensions/variable_definition'
require 'dimensions/variable_design'
require 'dimensions/loop_design'
require 'dimensions/page_definition'
require 'dimensions/mdd_class'

module Dimensions
  class Metadata
    include XpathHelper
    attr_reader :ids

    def self.read( mddfile, &block)
      file = File.open( mddfile)
      begin
	self.new( file, &block)
      ensure
	file.close
      end
    end

    def initialize( mddfile)
      @node = Nokogiri::XML( mddfile)
      @node = @node.root.children.first
      @ids = @node.xpath( "//*[@id]").inject({}) {|map,node| map[ node[ "id"]] = node ; map }
      yield @node if block_given?
    end

    def datasource_connection_string( datasource = default_datasource)
      connection = @node.xpath( "datasources/connection[@name='#{datasource}']").first
      connection[ 'dblocation']
    end

    def default_datasource
      @node.xpath( 'datasources/@default').first.value
    end

    def simple_variable_names
      variable_designs.select {|v| v.definition.type != :static && v.definition.casedata? }.map {|v| v.name }
    end

    def loop_variable_names
      loop_designs.map do |l|
	l1 = l.iteration_names
	classes = l.iteration_class_names
	l1.product( classes).map {|a,b| "#{a}.#{b}" }
      end.flatten
    end

    def system_variable_names
      classes = instances_for_xpath( "system/class", MDDClass)
      classes.map {|c| c.field.variables.map {|v| "#{c.name}.#{v.name}" } }.flatten
    end

    def variable_definitions
      @variable_definitions ||= instances_for_xpath( 'definition/variable', VariableDefinition)
    end

    def variable_designs
      @variable_designs ||= instances_for_xpath( 'design/fields/variable', VariableDesign)
    end

    def loop_designs
      @loop_designs ||= instances_for_xpath( 'design/fields/loop', LoopDesign)
    end

    def page_definitions
      @page_definitions ||= instances_for_xpath( 'definition/page', PageDefinition)
    end

    def category_map
      @category_map ||= Hash[ @node.xpath( 'categorymap/categoryid').map {|node| [ node[ 'name'], node[ 'value'].to_i ]}]
    end

    def category_reverse_map
      @category_reverse_map ||= category_map.invert
    end
  end
end
