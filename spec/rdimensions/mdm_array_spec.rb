require "spec_helper"

describe RDimensions::MDMArray do
  let(:doc) { RDimensions::Document.read(file_fixture("P4550054.mdd")) }

  context "simple loops" do
    let(:grq9) { doc.fields.find {|f| f.name == "GRQ9" } }

    it "knows its basic information" do
      expect(grq9.name).to eq "GRQ9"
      expect(grq9).to be_a(described_class)
    end

    it "knows its place in the document" do
      expect(grq9.document).to eq doc
      expect(grq9.parent).to eq doc
    end

    it "knows its label" do
      expect(grq9.labels.dig(:label, :question, "en-US")).to eq "How often do you purchase each of the following types of foods for your household?"
    end

    it "knows its indexes" do
      expect(grq9.categories.first.map( &:name)).to eq ["_01", "_02", "_03", "_04", "_05"]
      expect(grq9.categories.first.map( &:label)).to eq ["Packaged, pre-sliced bread, buns and rolls", "Sausage", "Hot dogs", "Lunch meat", "Frozen cakes, pies or other desserts"]
    end

    it "knows its class" do
      mdm_class = grq9.mdm_class
      expect(mdm_class.name).to eq "@class"
      expect(mdm_class.fields.size).to eq 1
      field = mdm_class.fields.first
      expect(field.name).to eq "Q9"
    end

    it "allows navigation" do
      mdm_class = grq9.mdm_class
      expect(mdm_class.parent).to eq grq9
      expect(mdm_class.fields.first.parent).to eq mdm_class
    end
  end
end
