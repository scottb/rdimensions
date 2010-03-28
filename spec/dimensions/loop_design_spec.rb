require 'spec_helper'

module Dimensions
  FIXTURE_FILENAME = File.expand_path( File.dirname(__FILE__) + '/../fixtures/P4550054.mdd')

  describe LoopDesign do
    context 'in a valid mdd' do
      before do
	@dataset = Metadata.read( FIXTURE_FILENAME)
      end

      it 'can identify the iterations' do
	grq9 = @dataset.loop_designs.find {|lv| lv.name == 'GRQ9' }
	iterations = grq9.iteration_names
	iterations.should include( 'GRQ9[{_01}]')
	iterations.should_not include( 'GRQ9[{_15}]')
      end

      it 'can identify the iteration class names' do
	grq9 = @dataset.loop_designs.find {|lv| lv.name == 'GRQ9' }
	classes = grq9.iteration_class_names
	classes.should == ["Q9"]
      end

      it 'can identify the iteration class names for nested iterations' do
	l27 = @dataset.loop_designs.find {|lv| lv.name == 'LoopQ27ToQ29' }
	classes = l27.iteration_class_names
	classes.should == ["BlockQ27ToQ29.Q27", "BlockQ27ToQ29.Q28", "BlockQ27ToQ29.Q29"]
      end

      it 'recognizes helper variables' do
	l30 = @dataset.loop_designs.find {|lv| lv.name == 'LoopQ30ToQ31' }
	classes = l30.iteration_class_names
	classes.should == ['Q30POS', 'Q31NEG', 'Q30POS.Codes', 'Q31NEG.Codes']
      end
    end
  end
end
