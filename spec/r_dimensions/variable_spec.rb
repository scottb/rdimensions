# frozen_string_literal: true

require "spec_helper"

RSpec.describe RDimensions::Variable do
  let(:doc) { RDimensions::Document.read(file_fixture("P4550054.mdd")) }

  describe "definition" do
    context "with case data" do
      let(:q2) { doc.variables.find {|f| f.name == "Q2" } }

      it "knows its basic information" do
        expect(q2.name).to eq "Q2"
        expect(q2).to be_a(described_class)
        expect(q2).to have_case_data
        expect(q2.data_type).to eq :category
      end

      it "knows its place in the document" do
        expect(q2.document).to eq(doc)
        expect(q2.parent).to eq(doc)
      end

      it "knows its labels" do
        expect(q2.labels.dig(:label, :question, "en-US")).to eq "In which of the following categories is your age?"
      end

      it "knows its categories" do
        expect(q2.closed_categories.size).to eq 7
        cats = q2.closed_categories
        expect(cats.map(&:name)).to eq %w[_01 _02 _03 _04 _05 _06 _07]
        expect(cats.map(&:label)).to eq ["Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or older"]
      end

      it "knows its min and max counts" do
        expect(q2.min_value).to eq 1
        expect(q2.max_value).to eq 1
      end

      it "allows navigation the categories" do
        cats = q2.categories
        # expect(cats.parent).to eq q2
        expect(cats.first.parent).to eq q2
      end
    end

    context "without case data" do
      let(:fhi) { doc.fields.find {|f| f.name == "FHI" } }

      it "knows its basic information" do
        expect(fhi.name).to eq "FHI"
        expect(fhi).not_to have_case_data
        expect(fhi.data_type).to eq :category
      end
    end

    describe "nested categories" do
      let(:q1) { doc.fields.find {|f| f.name == "Q1" } }

      it "knows its categories" do
        pending "fixing the spec"
        cats = q1.categories.categories
        expect(cats.map(&:label)).to include("Alabama", "Virginia")
        expect(cats.size).to eq 53
      end

      it "computes the closure" do
        pending "fixing the spec"
        cats = q1.categories.closure
        expect(cats.size).to eq 53
        expect(cats.map(&:label)).to include("Alabama", "Virginia")
      end
    end

    describe "system variables" do
      let(:respondent) { doc.fields.find {|f| f.name == "Respondent" } }

      it "knows it's a system variable" do
        expect(respondent).to be_a_system
      end
    end
  end
end
