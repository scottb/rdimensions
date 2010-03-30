require 'spec_helper'

module Dimensions
  describe MDMObject do
    o = Object.new
    o.extend( MDMObject)
    [:reference?, :system?, :object_type_value, :parent, :properties, :uuid, :document, :name].each do |sym|
      o.respond_to?( sym).should == true
    end
  end

  describe Document do
    it "is an MDMObject" do
      f = open( P4550054)
      doc = Document.new( f)
      f.close
      doc.should be_a( MDMObject)
    end

    it "knows what version of the MDM interface it supports" do
      Document.mdm_version.should == '5.0.3.3066'
    end

    it "can be read from a file" do
      doc = Document.read( P4550054)
      doc.should_not be_nil
    end

    context "with a valid MDD file" do
      before do
	@doc = Document.read( P4550054)
      end

      it "knows it's a document" do
	@doc.object_type_value == :document
      end

      it "knows its url" do
	@doc.url.should == File.expand_path( P4550054)
      end

      it "is its own document" do
	@doc.document.should equal( @doc)
      end

      it "holds a reference to the underlying XML" do
	@doc.xml.should be_a( Nokogiri::XML::Document)
      end

      it "has the category map" do
	@doc.category_map.should have_key( '_01')
	@doc.category_map[ '_01'].should == 79
	@doc.category_map.should have( 228).elements
      end

      it "knows what MDM version created it" do
	@doc.created_by_version.should == '5.0.3.3066'
      end

      it "knows what MDM version last updated it" do
	@doc.last_updated_by_version.should == '5.0.3.3066'
      end

      it "knows the label types" do
	@doc.should have( 1).label_types
	lc = @doc.label_types.first
	lc.should be_a( Context)
	lc.name.should == 'LABEL'
      end

      it "knows the base label type" do
	@doc.label_types.base.should == 'Label'
      end

      it "knows the current label type" do
	@doc.label_types.current.should == 'Label'
	@doc.label_types.current = 'test'
	@doc.label_types.current.should == 'test'
	@doc.label_types.base.should == 'Label'
	@doc.label_types.current = nil
	@doc.label_types.current.should == 'Label'
      end

      it "knows the user contexts" do
	@doc.should have( 5).contexts
	c = @doc.contexts
	c.map( &:name).should == [ 'ANALYSIS', 'QUESTION', 'QC', 'MRSTUDIO', 'CARDCOL' ]
      end

      it "knows the base user context" do
	@doc.contexts.base.should == 'Question'
      end

      it "knows the routing contexts" do
	@doc.should have( 1).routing_contexts
	@doc.routing_contexts.first.name.should == 'WEB'
	@doc.routing_contexts.base.should == 'Web'
      end

      it "is a labeled object" do
	@doc.should have( :no).labels
      end

      #it "#hacks" do ; @doc.node.xpath( '*').map( &:name).grep( /types/).should == ['hack'] ; end
      it "#hacks TBD" do
	pending { @doc.fields }
	pending { @doc.languages }
	pending { @doc.pages }
	pending { @doc.data_source_properties }
	pending { @doc.data_sources }
      end

      it "raises NotYetImplementedException on deferred API entries" do
	lambda { @doc.log_action }.should raise_error NotYetImplementedException
	lambda { @doc.valid? }.should raise_error NotYetImplementedException
	lambda { @doc.valid_version? }.should raise_error NotYetImplementedException
	lambda { @doc.join }.should raise_error NotYetImplementedException
	lambda { @doc.join_conflicts }.should raise_error NotYetImplementedException
      end

      it "reminds me to remove the node accessors when I'm done" do
	pending "a stable design" do
	  @doc.should_not respond_to( :node)
	end
      end
    end
  end
end
=begin
read-only
  fields			- a heterogeneous collection of objects that defined the hierarchical structure of the questionnaire
  languages			- a list of languages used in the document
  pages				- a collection of Page objects
  routing			- a collection of RoutingItem objects; defines the order in which the questions defined in the IDocument.Fields collection are to be asked
  data_source_properties	- a collection of custom properties that relate to the current data_source (source-specific information)
  data_sources			- a collection of DataSource objects which hold details of case data

  items				- a Types object containing a collection of all objects in the Fields, Helperfields, Pages, and Types collections for the document
  routing_items			- a flat list of RoutingItem objects associated with the document; a view of IDocument.Routing expanded according to the IRoutingItems.Filter property
  save_logs			- a collection of SaveLog objects
  script_types			- a list of script types used for routing scripts; defaults to 'mrScriptBasic'
  selected_versions		- returns a SelectedVersions object, which stores the names of the currently selected versions
  full_label			- the full label of the object
  find_object			- returns the object with the specified uuid
  lcl				- an id representing the specified Language, Context, and Label Type for the document {:label_type, :context, :language}
  level_depth			- a number indicating the depth of the level in which this object is located; equivalent to the number of arrays above this object
  types				- a list of template objects in the document

  alias_map			- the alias map used for the current datasource
  make_instance_name		- returns the full name of a specific iteration when given a partial full name and one or more indexes that represent the iterations
  make_reference_name		- returns a name that can be used as a reference for the reference_name property
  templates			- the templates object containing a list of all the templates for the current object; templates define the presentation of the object when an interview is run
  variable_instance		- given a partial full name and one or more indexes that represent the iterations, this property returns the corresponding VariableInstance object
  variables			- a collection of VariableInstance objects that define the schema for the top-level virtual table (always VDATA); VariableInstance objects map a Variable object to its associated columns in the case data virtual tables;
				  For example: a categorical question that has one Other Specify category would typically have three VariableInstance objects.
					  The first represents the column that holds the responses to the category list
					  The second represents the helper field that stores the open-ended responses
					  The third represents the hlper field that stores the coded responses
  versions			- a collection of versions defined in the document
  version_sets			- stores the version expressions that have been used to open a superversion
read-write
  bulk_import			- sets the BulkImport flag, which can be used to prevent some validation and updating of structures; assumes that all the items being added are valid and that they are to be added in sequential order and that no items are to be removed or renamed
  current_version		- the name or expression that defines the currently selected version or versions
  enable_metadata_version_variable - controls whetehr the DataCollection.MetadataVersion system variable is to be enabled
  include_system_variables	- defines whether or not system variables are included in the document; setting this automatically creates the system variables
  open_mode			- the mode in which the document was opened
  script			- the mrScriptMetadata script for the document
=end
