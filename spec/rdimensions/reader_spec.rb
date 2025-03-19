require 'spec_helper'

describe RDimensions::Document do
  it "can be read from a file" do
    doc = described_class.read( P4550054)
    expect(doc.url).to eq File.expand_path(P4550054)
  end

  it "can parse the string directly" do
    File.open(P4550054) do |f|
      doc = described_class.parse(f.read)
      expect(doc.url).to be_nil
    end
  end
end
