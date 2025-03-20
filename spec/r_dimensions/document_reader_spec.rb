# frozen_string_literal: true

require "spec_helper"

RSpec.describe RDimensions::Document do
  let(:mdd) { file_fixture("P4550054.mdd") }

  it "can be read from a file" do
    doc = described_class.read(mdd)
    expect(doc.url).to eq mdd.to_s
  end

  it "can parse the string directly" do
    doc = described_class.parse(mdd.read)
    expect(doc.url).to be_nil
  end
end
