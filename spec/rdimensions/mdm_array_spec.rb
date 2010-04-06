require 'spec_helper'

module RDimensions
  describe MDMArray do
    before( :all) do
      @doc = Document.read( P4550054)
    end

    context "simple loops" do
      before do
	@grq9 = @doc.fields.find {|f| f.name == 'GRQ9' }
      end

      it "knows its basic information" do
	@grq9.name.should == 'GRQ9'
	@grq9.should be_a( MDMArray)
      end

      it "knows its place in the document" do
	@grq9.document.should equal( @doc)
	@grq9.parent.should_not be_nil
	@grq9.parent.should equal( @doc)
      end

      it "knows its label" do
	@grq9.labels[ :label][ :question][ 'en-US'].should == 'How often do you purchase each of the following types of foods for your household?'
      end

      it "knows its indexes" do
	@grq9.categories.map( &:name).should == ["_01", "_02", "_03", "_04", "_05"]
	@grq9.categories.map( &:label).should == ["Packaged, pre-sliced bread, buns and rolls", "Sausage", "Hot dogs", "Lunch meat", "Frozen cakes, pies or other desserts"]
      end

      it "knows its class" do
	mdm_class = @grq9.mdm_class
	mdm_class.name.should == "@class"
	mdm_class.should have( 1).fields
	field = mdm_class.fields.first
	field.name.should == 'Q9'
      end

      it "allows navigation" do
	mdm_class = @grq9.mdm_class
	mdm_class.parent.should equal( @grq9)
	mdm_class.fields.first.parent.should equal( mdm_class)
      end
    end
  end
end
