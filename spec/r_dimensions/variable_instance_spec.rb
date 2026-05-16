# frozen_string_literal: true

require "spec_helper"

RSpec.describe RDimensions::VariableInstance do
  let(:document) { RDimensions::Document.read(file_fixture("P4550054.mdd")) }

  it "can enumerate the variable instances" do
    expect(document.variable_instances.size).to eq 236
  end

  describe "Variable" do
    it "has a single instance" do
      q2 = document.fields.find {|v| v.name == "Q2" }
      expect(q2.variable_instances.size).to eq 1
      instance = q2.variable_instances.first
      expect(instance.name).to eq "Q2"
      expect(instance.sources.size).to eq 1
      expect(instance.sources.map(&:name)).to eq ["Q2"]
    end
  end

  describe "MDMClass" do
    it "has an instance per variable" do
      block = document.fields.find {|v| v.name == "LoopQ27ToQ29" }.mdm_class.fields.first
      expect(block.variable_instances.size).to eq 3
      expect(block.variable_instances.map(&:name)).to include("BlockQ27ToQ29.Q28")
      instance = block.variable_instances.first
      expect(instance.sources.size).to eq 2
      expect(instance.sources.map(&:name)).to eq %w[BlockQ27ToQ29 Q27]
    end
  end

  describe "MDMArray" do
    it "has an instance per index per variable" do
      grq9 = document.fields.find {|v| v.name == "GRQ9" }
      expect(grq9.variable_instances.size).to eq 5
      expect(grq9.variable_instances.map(&:name)).to include("GRQ9[{_02}].Q9")
      instance = grq9.variable_instances.first
      expect(instance.sources.size).to eq 3
      expect(instance.sources.map(&:name)).to eq %w[GRQ9 _01 Q9]
    end

    it "handles the blocked case" do
      lq27 = document.fields.find {|v| v.name == "LoopQ27ToQ29" }
      expect(lq27.variable_instances.size).to eq 8 * 3
      expect(lq27.variable_instances.map(&:name)).to include("LoopQ27ToQ29[{D}].BlockQ27ToQ29.Q28")
      instance = lq27.variable_instances.first
      expect(instance.sources.size).to eq 4
      expect(instance.sources.map(&:name)).to eq %w[LoopQ27ToQ29 A BlockQ27ToQ29 Q27]
    end
  end

  describe "Document" do
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

  describe "duplicate othervariables within a category" do
    let(:mdd) { <<~XML }
      <?xml version="1.0" encoding="UTF-8"?>
      <xml><mdm:metadata xmlns:mdm="http://www.spss.com/mr/dm/metadatamodel/Arc 3/2000-02-04">
        <datasources/>
        <definition>
          <othervariable id="ov-first"  name="Other_specify" type="2" min="0" max="253"/>
          <othervariable id="ov-second" name="Other_specify" type="2" min="0" max="253"/>
          <othervariable id="ov-third"  name="Other_specify" type="2" min="0" max="253"/>
          <othervariable id="ov-other"  name="Other_specify" type="2" min="0" max="253"/>
          <variable id="q1-id" name="Q1" type="3" min="1" max="1">
            <categories>
              <category name="Option1"/>
              <category name="Option2">
                <othervariable ref="ov-first"  name="Other_specify"/>
                <othervariable ref="ov-second" name="Other_specify"/>
                <othervariable ref="ov-third"  name="Other_specify"/>
              </category>
            </categories>
          </variable>
          <variable id="q2-id" name="Q2" type="3" min="1" max="1">
            <categories>
              <category name="A">
                <othervariable ref="ov-first" name="Other_specify"/>
              </category>
              <category name="B">
                <othervariable ref="ov-other" name="Other_specify"/>
              </category>
            </categories>
          </variable>
        </definition>
        <system><fields/></system>
        <design><fields>
          <variable ref="q1-id" name="Q1"/>
          <variable ref="q2-id" name="Q2"/>
        </fields></design>
        <languages base="en-US"/>
        <contexts base="Question"/>
        <labeltypes base=""/>
        <routingcontexts base="Web"/>
        <categorymap/>
      </mdm:metadata></xml>
    XML

    let(:document) { RDimensions::Document.parse(mdd) }
    let(:instance_names) { document.variable_instances.map(&:name) }

    it "collapses duplicate-name siblings into a single instance" do
      expect(instance_names.count("Q1.Other_specify")).to eq 1
    end

    it "still produces one instance per category when the same name appears in sibling categories" do
      expect(instance_names.count("Q2.Other_specify")).to eq 2
    end

    it "keeps the first duplicate in document order" do
      q1_other = document.variable_instances.find {|vi| vi.name == "Q1.Other_specify" }
      expect(q1_other.sources.first.uuid).to eq "ov-first"
    end
  end
end
