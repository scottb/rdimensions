require 'spec_helper'

module Dimensions
  describe MDMArray do
    before( :all) do
      @doc = Document.read( P4550054)
    end

    before do
      @grq9 = @doc.fields.find {|f| f.name == 'GRQ9' }
    end

    it "knows its basic information" do
      @grq9.name.should == 'GRQ9'
      @grq9.should_not be_a_reference
      @grq9.should be_a( MDMArray)
    end

    it "knows its label" do
      @grq9.labels[ :label][ :question][ 'en-US'].should == 'How often do you purchase each of the following types of foods for your household?'
    end
  end
end
