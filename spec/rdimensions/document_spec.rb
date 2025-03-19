require "spec_helper"

describe RDimensions::Document do
  it "knows what version of the MDM interface it supports" do
    expect(described_class.mdm_version).to eq "5.0.3.3066"
  end

  it "can construct instance names from full names and indexes" do
    expect(described_class.make_instance_name( "GRQ9[..].Q9", "{_01}")).to eq "GRQ9[{_01}].Q9"
    expect(described_class.make_instance_name( "GRQ9", "{_01}")).to eq "GRQ9"
    expect(described_class.make_instance_name( "MyLoop[..].MyGrid[..].pref", "2", "{A}")).to eq "MyLoop[2].MyGrid[{A}].pref"
    expect(described_class.make_instance_name( "MyLoop[..].MyGrid[..].pref", "2")).to eq "MyLoop[2].MyGrid[..].pref"
    expect(described_class.make_instance_name( "MyLoop[..].MyGrid[..].pref")).to eq "MyLoop[..].MyGrid[..].pref"
  end

  context "with a valid MDD file" do
    let(:doc) { described_class.read(P4550054) }

    it "is its own document" do
      expect(doc.document).to eq doc
    end

    it "holds a reference to the underlying XML" do
      expect(doc.xml).to be_a Nokogiri::XML::Document
    end

    it "has the category map" do
      expect(doc.category_map.keys).to include("_01", "_02", "lst_qstate._44")
      expect(doc.category_map[ "_01"]).to eq 79
      expect(doc.category_map.size).to eq 228
    end

    it "knows what MDM version created it" do
      expect(doc.created_by_version).to eq "5.0.3.3066"
    end

    it "knows what MDM version last updated it" do
      expect(doc.last_updated_by_version).to eq "5.0.3.3066"
    end

    it "knows the label types" do
      expect(doc.label_types.size).to eq 1
      lc = doc.label_types.first
      expect(lc).to be_a RDimensions::Context
      expect(lc.name).to eq "LABEL"
    end

    it "knows the base label type" do
      expect(doc.label_types.base).to eq "Label"
    end

    it "knows the current label type" do
      expect(doc.label_types.current).to eq "Label"
      doc.label_types.current = "test"
      expect(doc.label_types.current).to eq "test"
      expect(doc.label_types.base).to eq "Label"
      doc.label_types.current = nil
      expect(doc.label_types.current).to eq "Label"
    end

    it "knows the user contexts" do
      expect(doc.contexts.map( &:name)).to eq ["ANALYSIS", "QUESTION", "QC", "MRSTUDIO", "CARDCOL" ]
    end

    it "knows the base user context" do
      expect(doc.contexts.base).to eq "Question"
    end

    it "knows the routing contexts" do
      expect(doc.routing_contexts.size).to eq 1
      expect(doc.routing_contexts.first.name).to eq "WEB"
      expect(doc.routing_contexts.base).to eq "Web"
    end

    it "is a labeled object" do
      expect(doc.labels).to be_empty
    end

    it "knows what languages are available" do
      expect(doc.languages.size).to eq 1
      expect(doc.languages.first.xml_name).to eq "EN-US"
    end

    it "knows what datasources are available" do
      expect(doc.data_sources.size).to eq 1
      expect(doc.data_sources.default).to eq "mrRdbDsc2"
      expect(doc.data_sources.current).to eq "mrRdbDsc2"
      ds = doc.data_sources.first
      expect(ds.name).to eq "mrRdbDsc2"
      expect(ds.dblocation).to match /^Provider=SQLOLEDB\.1;/
      expect(ds.cdscname).to eq "mrRdbDsc2"
      expect(ds.project).to eq "P4550054"
    end

    it "can enumerate the fields" do
      expect(doc.fields.size).to eq 3 + 57 + 20 + 1
      expect(doc.fields.map(&:name)).to include("Q1", "GRQ9", "LoopQ27ToQ29", "LoopQ30ToQ31")
    end

    it "raises NotYetImplementedException on deferred API entries" do
      expect { doc.pages }.to raise_error RDimensions::NotYetImplementedException
      expect { doc.log_action }.to raise_error RDimensions::NotYetImplementedException
      expect { doc.valid? }.to raise_error RDimensions::NotYetImplementedException
      expect { doc.valid_version? }.to raise_error RDimensions::NotYetImplementedException
      expect { doc.join }.to raise_error RDimensions::NotYetImplementedException
      expect { doc.join_conflicts }.to raise_error RDimensions::NotYetImplementedException
      expect { doc.data_source_properties }.to raise_error RDimensions::NotYetImplementedException
    end
  end
end
