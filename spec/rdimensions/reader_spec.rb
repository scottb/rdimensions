require 'spec_helper'

module RDimensions
  describe Document do
    it "can be read from a file" do
      doc = Document.read( P4550054)
      doc.url.should == File.expand_path( P4550054)
    end

    it "can parse the string directly" do
      File.open( P4550054) do |f|
	doc = Document.parse( f.read)
	doc.url.should == nil
      end
    end
  end
end
