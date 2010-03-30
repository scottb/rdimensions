require 'spec_helper'

module Dimensions
  describe Variable do
    before do
      @doc = Document.read( P4550054)
    end

    context "reference" do
      before do
	@q2 = Variable.new( @doc, @doc.node.at( 'design/fields/variable[38]'))
      end

      it "knows its basic information" do
	@q2.name.should == 'Q2'
	@q2.should be_a_reference
	@q2.object_type_value.should == :variable
      end
    end

    context "definition" do
      context "with case data" do
	before do
	  @q2 = Variable.new( @doc, @doc.node.at( 'definition/variable[71]'))
	end

	it "knows its basic information" do
	  @q2.name.should == 'Q2'
	  @q2.should_not be_a_reference
	  @q2.object_type_value.should == :variable
	  @q2.should have_case_data
	  @q2.data_type.should == :category
	end

	it "knows its labels" do
	  @q2.labels[ :label][ :question][ 'en-US'].should == 'In which of the following categories is your age?'
	end

	it "knows its categories" do
	  @q2.should have( 7).categories
	  cats = @q2.categories
	  cats.map( &:label).should == ['Under 18', '18-24', '25-34', '35-44', '45-54', '55-64', '65 or older']
	end
      end

      context "without case data" do
	before do
	  @fhi = Variable.new( @doc, @doc.node.at( 'definition/variable[1]'))
	end

	it "knows its basic information" do
	  @fhi.name.should == 'FHI'
	  @fhi.should_not have_case_data
	  @fhi.data_type.should == :category
	end
      end

      context "other types" do
	it "should recognize the 'none' type" do
	  Variable.new( @doc, @doc.node.at( 'definition/variable[50]')).data_type.should == :none
	end

	it "should recognize text types" do
	  Variable.new( @doc, @doc.node.at( 'definition/variable[58]')).data_type.should == :text
	end
      end

      context "nested categories" do
	before do
	  @q1 = Variable.new( @doc, @doc.node.at( 'definition/variable[70]'))
	end

	it "should know its categories" do
	  pending { @q1.should have( 50).categories }
	end
      end
    end
  end
end
