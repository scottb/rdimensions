require 'spec_helper'

module RDimensions
  describe VariableInstance do
    before( :all) do
      @document = Document.read( P4550054)
    end

    it "can enumerate the variable instances" do
      @document.should have( 236).variable_instances
    end

    context Variable do
      it "has a single instance" do
	q2 = @document.fields.find {|v| v.name == 'Q2' }
	q2.should have( 1).variable_instances
	instance = q2.variable_instances.first
	instance.name.should == 'Q2'
	instance.should have( 1).sources
	instance.sources.map( &:name).should == [ 'Q2' ]
      end
    end

    context MDMClass do
      it "has an instance per variable" do
	block = @document.fields.find {|v| v.name == 'LoopQ27ToQ29' }.mdm_class.fields.first
	block.should have( 3).variable_instances
	block.variable_instances.map( &:name).should include( 'BlockQ27ToQ29.Q28')
	instance = block.variable_instances.first
	instance.should have( 2).sources
	instance.sources.map( &:name).should == ['BlockQ27ToQ29', 'Q27']
      end
    end

    context MDMArray do
      it "has an instance per index per variable" do
	grq9 = @document.fields.find {|v| v.name == 'GRQ9' }
	grq9.should have( 5).variable_instances
	grq9.variable_instances.map( &:name).should include( 'GRQ9[{_02}].Q9')
	instance = grq9.variable_instances.first
	instance.should have( 3).sources
	instance.sources.map( &:name).should == ['GRQ9', '_01', 'Q9']
      end

      it "handles the blocked case" do
	lq27 = @document.fields.find {|v| v.name == 'LoopQ27ToQ29' }
	lq27.should have( 8*3).variable_instances
	lq27.variable_instances.map( &:name).should include( 'LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q28')
	instance = lq27.variable_instances.first
	instance.should have( 4).sources
	instance.sources.map( &:name).should == ['LoopQ27ToQ29', 'A', 'BlockQ27ToQ29', 'Q27']
      end
    end

    context Document do
      before do
	@instances = @document.variable_instances
	@instance_names = @instances.map( &:name)
      end

      it "finds simple variables" do
	@instance_names.should include( 'Q1', 'enowdt')
      end

      it "finds system classes" do
	@instance_names.should include( 'Respondent.Serial', 'Respondent.Origin', 'DataCollection.Status')
      end

      it "finds array members" do
	@instance_names.should include( 'GRQ9[{_01}].Q9', 'GRQ9[{_03}].Q9')
      end

      it "finds multi-level array members" do
	@instance_names.should include( 'LoopQ27ToQ29[{A}].BlockQ27ToQ29.Q27', 'LoopQ27ToQ29[{A}].BlockQ27ToQ29.Q29')
	@instance_names.should include( 'LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q27', 'LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q29')
      end
    end
  end
end
