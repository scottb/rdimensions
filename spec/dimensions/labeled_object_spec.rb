require 'spec_helper'

module Dimensions
  describe LabeledObject do
    before( :all) do
      @doc = Document.read( P4550054)
    end

    before do
      @model_node = @doc.vdef( 'Status').categories.first
    end

    it "has an entry for each context" do
      @model_node.should have( 1).labels
    end

    context "individual labels" do
      before do
	@label = @model_node.labels[ :label]
      end

      it "knows its context" do
	@label.context.should == 'LABEL'
      end

      it "has an entry for each user context" do
	@label.should have( 2).entries
      end

      it "has a string for each language" do
	@label[ :question].should have( 20).entries
	@label[ :question][ 'en-US'].should == 'Completed successfully'
	@label[ :question][ 'de-DE'].should == 'Erfolgreich abgeschlossen'
	@label[ :analysis][ 'en-US'].should == 'Completed successfully'
	@label[ :analysis][ 'de-DE'].should == 'Erfolgreich abgeschlossen'
      end
    end
  end
end
