require 'spec_helper'

module Dimensions
  describe LabeledObject do
    before do
      doc = Document.read( P4550054)
      @model_node = MDMNode.new( doc, doc.node.at( 'definition/variable[129]/categories/category[9]'))
      @model_node.extend( LabeledObject)
    end

    it "has an entry for each context" do
      @model_node.should have( 1).labels
    end

    context "individual labels" do
      before do
	@label = @model_node.labels[ :label]
      end

      it "is knows its context" do
	@label.context.should == 'LABEL'
      end

      it "has an entry for each user context" do
	@label.should have( 2).entries
      end

      it "has a string for each language" do
	@label[ :question].should have( 20).entries
	@label[ :question][ 'en-US'].should == 'Reviewed'
	@label[ :question][ 'de-DE'].should == 'Durchsicht'
	@label[ :analysis][ 'en-US'].should == 'Reviewed'
	@label[ :analysis][ 'de-DE'].should == 'Durchsicht'
      end
    end
  end
end
