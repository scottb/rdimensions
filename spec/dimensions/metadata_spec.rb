require 'spec_helper'

module Dimensions
  FIXTURE_FILENAME = File.expand_path( File.dirname(__FILE__) + '/../fixtures/P4550054.mdd')

  describe Metadata do
    it 'can be created from an IO object' do
      file = File.open( FIXTURE_FILENAME)
      dataset = Metadata.new( file)
      file.close
      dataset.should_not be_nil
    end

    it 'can be created with just a filename' do
      dataset = Metadata.read( FIXTURE_FILENAME)
      dataset.should_not be_nil
    end

    describe '#read' do
      it 'raises IOError on bad filenames' do
	lambda {
	  Metadata.read( 'bogus.mdd')
	}.should raise_error( Errno::ENOENT)
      end
    end

    context 'with a valid mdd' do
      before do
	@dataset = Metadata.read( FIXTURE_FILENAME)
      end

      context 'datasources' do
	it 'knows the default datasource' do
	  @dataset.default_datasource.should == 'mrRdbDsc2'
	end

	it 'knows the ADO connection string for datasources' do
	  @dataset.datasource_connection_string( 'mrRdbDsc2').should =~ /^Provider=SQLOLEDB\.1;/
	end

	it 'knows the default ADO connection string for datasources' do
	  @dataset.datasource_connection_string.should =~ /^Provider=SQLOLEDB\.1;/
	end
      end

      it 'knows the variables in the design' do
	names = @dataset.simple_variable_names
	names.should include( 'Q1')
	names.should include( 'COMP')
	names.should have( 35).entries
      end

      it 'knows the loops in the design' do
	names = @dataset.loop_variable_names
	names.should include( 'GRQ9[{_01}].Q9')
	names.should_not include( 'GRQ9[{_01}].Q10')
	names.should include( 'LoopQ27ToQ29[{A}].BlockQ27ToQ29.Q27')
	names.should_not include( 'LoopQ27ToQ29[{A}].BlockQ27ToQ29')
	names.should_not include( 'LoopQ27ToQ29[{A}].Q27')
	names.should include( 'LoopQ30ToQ31[{A}].Q30POS')
	names.should include( 'LoopQ30ToQ31[{A}].Q30POS.Codes')
	names.should_not include( 'LoopQ30ToQ31[{A}].Codes')
	names.should have( 136).entries
      end

      it 'knows the system variables' do
	names = @dataset.system_variable_names
	names.should include( 'Respondent.Serial')
	names.should have( 23).entries
      end
    end
  end
end
