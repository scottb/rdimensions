require 'spec_helper'

module Dimensions
  describe Variable do
    before do
      @doc = Document.read( P4550054)
    end

    context "definition" do
      context "with case data" do
	before do
	  @q2 = @doc.fields.find {|f| f.name == 'Q2' }
	end

	it "knows its basic information" do
	  @q2.name.should == 'Q2'
	  @q2.should_not be_a_reference
	  @q2.should be_a( Variable)
	  @q2.should have_case_data
	  @q2.data_type.should == :category
	end

	it "knows its labels" do
	  @q2.labels[ :label][ :question][ 'en-US'].should == 'In which of the following categories is your age?'
	end

	it "knows its categories" do
	  @q2.should have( 7).categories
	  cats = @q2.categories
	  cats.map( &:name).should == ['_01', '_02', '_03', '_04', '_05', '_06', '_07']
	  cats.map( &:label).should == ['Under 18', '18-24', '25-34', '35-44', '45-54', '55-64', '65 or older']
	end
      end

      context "without case data" do
	before do
	  @fhi = @doc.fields.find {|f| f.name == 'FHI' }
	end

	it "knows its basic information" do
	  @fhi.name.should == 'FHI'
	  @fhi.should_not have_case_data
	  @fhi.data_type.should == :category
	end
      end

      context "nested categories" do
	before do
	  @q1 = @doc.fields.find {|f| f.name == 'Q1' }
	end

	it "should know its categories" do
	  pending { @q1.should have( 50).categories }
	end
      end
    end
  end
end
