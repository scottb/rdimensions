require 'spec_helper'

module Dimensions
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

      it "knows its label" do
	@grq9.labels[ :label][ :question][ 'en-US'].should == 'How often do you purchase each of the following types of foods for your household?'
      end

      it "knows its indexes" do
	@grq9.categories.map( &:name).should == ["_01", "_02", "_03", "_04", "_05"]
	@grq9.categories.map( &:label).should == ["Packaged, pre-sliced bread, buns and rolls", "Sausage", "Hot dogs", "Lunch meat", "Frozen cakes, pies or other desserts"]
      end
    end

#    context "helper variables" do
#      before do
#	@var = @doc.fields.find {|f| f.name == 'LoopQ27ToQ29' }
#      end
#    end
  end
end
