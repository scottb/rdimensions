require 'spec_helper'

module Dimensions
  describe Document do
    it "can be read from a file" do
      doc = Document.read( P4550054)
      doc.url.should == File.expand_path( P4550054)
    end
  end
end
