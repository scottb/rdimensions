require "spec_helper"

describe RDimensions::LabeledObject do
  let(:doc) { RDimensions::Document.read(file_fixture("P4550054.mdd")) }
  let(:model_node) { doc.variables.find {|v| v.name == "Status" }.categories.first }

  it "knows its place in the document" do
    expect(model_node.document).to eq doc
    expect(model_node.parent).not_to be_nil
    expect(model_node.parent).not_to eq doc
  end

  it "has an entry for each context" do
    expect(model_node.size).to eq 9
  end

  context "label access defaults" do
    after do
      doc.default_label_context = nil
      doc.default_label_language = nil
    end

    it "knows its default" do
      expect(doc.default_label_context).to eq :question
      expect(doc.default_label_language).to eq "en-us"
      expect(model_node.first.label).to eq "Completed successfully"
      doc.default_label_context = :analysis
      expect(model_node.first.label).to eq "Completed successfully"
      doc.default_label_language = "es-ES"
      expect(model_node.first.label).to eq "Completada exitósamente"
    end

    it "falls back gracefully on missing entries" do
      model_node = doc.variables.find {|v| v.name == "Q1" }
      expect(model_node.label).to eq "First, in which of the following states do you currently reside?"
      doc.default_label_context = :analysis
      expect(model_node.label).to eq "First, in which of the following states do you currently reside?"
      doc.default_label_language = "de-DE"
      expect(model_node.label).to eq "First, in which of the following states do you currently reside?"
    end
  end

  context "individual labels" do
    let(:label) { model_node.first.labels[ :label] }

    it "knows its context" do
      expect(label.context).to eq "LABEL"
    end

    it "has an entry for each user context" do
      expect(label.size).to eq 2
    end

    it "has a string for each language" do
      expect(label[:question].size).to eq 20
      expect(label[:question]).to include(
        "en-US" => "Completed successfully",
        "de-DE" => "Erfolgreich abgeschlossen",
      )
    end
  end
end
