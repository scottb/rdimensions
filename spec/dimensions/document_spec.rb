require 'spec_helper'

module Dimensions
  describe Document do
    it "knows what version of the MDM interface it supports" do
      Document.mdm_version.should == '5.0.3.3066'
    end

    it "can construct instance names from full names and indexes" do
      Document.make_instance_name( 'GRQ9[..].Q9', '{_01}').should == 'GRQ9[{_01}].Q9'
      Document.make_instance_name( 'GRQ9', '{_01}').should == 'GRQ9'
      Document.make_instance_name( 'MyLoop[..].MyGrid[..].pref', '2', '{A}').should == 'MyLoop[2].MyGrid[{A}].pref'
      Document.make_instance_name( 'MyLoop[..].MyGrid[..].pref', '2').should == 'MyLoop[2].MyGrid[..].pref'
      Document.make_instance_name( 'MyLoop[..].MyGrid[..].pref').should == 'MyLoop[..].MyGrid[..].pref'
    end

    context "with a valid MDD file" do
      before( :all) do
	@doc = Document.read( P4550054)
      end

      it "is its own document" do
	@doc.document.should equal( @doc)
      end

      it "holds a reference to the underlying XML" do
	@doc.xml.should be_a( Nokogiri::XML::Document)
      end

      it "has the category map" do
	@doc.category_map.keys.should include( '_01', '_02', 'lst_qstate._44')
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

      it "knows what languages are available" do
	@doc.should have( 1).languages
	@doc.languages.first.xml_name.should == 'EN-US'
      end

      it "knows what datasources are available" do
	@doc.should have( 1).data_sources
	@doc.data_sources.default.should == 'mrRdbDsc2'
	@doc.data_sources.current.should == 'mrRdbDsc2'
	ds = @doc.data_sources.first
	ds.name.should == 'mrRdbDsc2'
	ds.dblocation.should =~ /^Provider=SQLOLEDB\.1;/
	ds.cdscname.should == 'mrRdbDsc2'
	ds.project.should == 'P4550054'
      end

      it "can enumerate the fields" do
	@doc.should have( 3 + 57 + 20 + 1).fields
	@doc.fields.map( &:name).should include( 'Q1', 'GRQ9', 'LoopQ27ToQ29', 'LoopQ30ToQ31')
      end

      it "raises NotYetImplementedException on deferred API entries" do
	lambda { @doc.pages }.should raise_error NotYetImplementedException
	lambda { @doc.log_action }.should raise_error NotYetImplementedException
	lambda { @doc.valid? }.should raise_error NotYetImplementedException
	lambda { @doc.valid_version? }.should raise_error NotYetImplementedException
	lambda { @doc.join }.should raise_error NotYetImplementedException
	lambda { @doc.join_conflicts }.should raise_error NotYetImplementedException
	lambda { @doc.data_source_properties }.should raise_error NotYetImplementedException
      end
    end
  end
end
