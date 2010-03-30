require 'spec_helper'

module Dimensions
  describe MDMArray do
    before do
      @doc = Document.read( P4550054)
      @grq9 = Variable.new( @doc, @doc.node.xpath( 'design/fields/loop[2]').first)
    end

    it "knows its basic information" do
      @grq9.name.should == 'GRQ9'
      @grq9.should_not be_a_reference
      @grq9.object_type_value.should == :array
    end

    it "knows its label" do
      @grq9.labels[ :label][ :question][ 'en-US'].should == 'How often do you purchase each of the following types of foods for your household?'
    end
  end
end
