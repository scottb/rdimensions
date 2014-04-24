require 'spec_helper'

module RDimensions
  describe LabeledObject do
    before( :all) do
      @doc = Document.read( P4550054)
    end

    before do
      @model_node = @doc.variables.find {|v| v.name == 'Status' }.categories.first
    end

    it "knows its place in the document" do
      @model_node.document.should equal( @doc)
      @model_node.parent.should_not be_nil
      @model_node.parent.should_not equal( @doc)
    end

    it "has an entry for each context" do
      @model_node.should have( 9).labels
    end

    context "label access defaults" do
      after do
	@doc.default_label_context = nil
	@doc.default_label_language = nil
      end

      it "knows its default" do
	@doc.default_label_context.should == :question
	@doc.default_label_language.should == 'EN-US'
	@model_node.first.label.should == 'Completed successfully'
	@doc.default_label_context = :analysis
	@model_node.first.label.should == 'Completed successfully'
	@doc.default_label_language = 'es-ES'
	@model_node.first.label.should == 'Completada exitósamente'
      end

      it "falls back gracefully on missing entries" do
	model_node = @doc.variables.find {|v| v.name == 'Q1' }
	model_node.label.should == 'First, in which of the following states do you currently reside?'
	@doc.default_label_context = :analysis
	model_node.label.should == 'First, in which of the following states do you currently reside?'
	@doc.default_label_language = 'de-DE'
	model_node.label.should == 'First, in which of the following states do you currently reside?'
      end
    end

    context "individual labels" do
      before do
	@label = @model_node.first.labels[ :label]
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
