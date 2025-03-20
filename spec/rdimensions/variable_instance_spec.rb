require "spec_helper"

describe RDimensions::VariableInstance do
  let(:document) { RDimensions::Document.read(file_fixture("P4550054.mdd")) }

  it "can enumerate the variable instances" do
    expect(document.variable_instances.size).to eq 236
  end

  context "Variable" do
    it "has a single instance" do
      q2 = document.fields.find {|v| v.name == "Q2" }
      expect(q2.variable_instances.size).to eq 1
      instance = q2.variable_instances.first
      expect(instance.name).to eq "Q2"
      expect(instance.sources.size).to eq 1
      expect(instance.sources.map(&:name)).to eq ["Q2"]
    end
  end

  context "MDMClass" do
    it "has an instance per variable" do
      block = document.fields.find {|v| v.name == "LoopQ27ToQ29" }.mdm_class.fields.first
      expect(block.variable_instances.size).to eq 3
      expect(block.variable_instances.map(&:name)).to include("BlockQ27ToQ29.Q28")
      instance = block.variable_instances.first
      expect(instance.sources.size).to eq 2
      expect(instance.sources.map(&:name)).to eq ["BlockQ27ToQ29", "Q27"]
    end
  end

  context "MDMArray" do
    it "has an instance per index per variable" do
      grq9 = document.fields.find {|v| v.name == "GRQ9" }
      expect(grq9.variable_instances.size).to eq 5
      expect(grq9.variable_instances.map(&:name)).to include("GRQ9[{_02}].Q9")
      instance = grq9.variable_instances.first
      expect(instance.sources.size).to eq 3
      expect(instance.sources.map(&:name)).to eq ["GRQ9", "_01", "Q9"]
    end

    it "handles the blocked case" do
      lq27 = document.fields.find {|v| v.name == "LoopQ27ToQ29" }
      expect(lq27.variable_instances.size).to eq 8*3
      expect(lq27.variable_instances.map(&:name)).to include("LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q28")
      instance = lq27.variable_instances.first
      expect(instance.sources.size).to eq 4
      expect(instance.sources.map(&:name)).to eq ["LoopQ27ToQ29", "A", "BlockQ27ToQ29", "Q27"]
    end
  end

  context "Document" do
    let(:instances) { document.variable_instances }
    let(:instance_names) { instances.map(&:name) }

    it "finds simple variables" do
      expect(instance_names).to include("Q1", "enowdt")
    end

    it "finds system classes" do
      expect(instance_names).to include("Respondent.Serial", "Respondent.Origin", "DataCollection.Status")
    end

    it "finds array members" do
      expect(instance_names).to include("GRQ9[{_01}].Q9", "GRQ9[{_03}].Q9")
    end

    it "finds multi-level array members" do
      expect(instance_names).to include("LoopQ27ToQ29[{A}].BlockQ27ToQ29.Q27", "LoopQ27ToQ29[{A}].BlockQ27ToQ29.Q29")
      expect(instance_names).to include("LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q27", "LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q29")
    end
  end
end
