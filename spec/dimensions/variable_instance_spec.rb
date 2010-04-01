require 'spec_helper'

module Dimensions
  describe VariableInstance do
    before( :all) do
      @document = Document.read( P4550054)
    end

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

    def dropjunk( node)
      node.children.each do |n|
	if %w(deleted versions properties).include?( n.name)
	  n.unlink
	elsif node.name == 'text'
	  node.content = node.content[0..20]
	else
	  dropjunk( n)
	end
      end
    end

    it "finds multi-level array members" do
      @instance_names.should include( 'LoopQ27ToQ29[{A}].BlockQ27ToQ29.Q27', 'LoopQ27ToQ29[{A}].BlockQ27ToQ29.Q29')
      @instance_names.should include( 'LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q27', 'LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q29')
    end
  end
end
