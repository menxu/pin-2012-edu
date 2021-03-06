require 'spec_helper'

describe MediaShareRule do
  let(:rule)     {MediaShareRule.new}
  let(:input)    {{:users => [1, 2, 3, 4]}}
  let(:expected) {input.merge({:teams   => [],
                               :courses => []})}

  context 'expression setter and getter' do
    subject {rule}

    describe '#build_expression' do
      subject {rule.build_expression(input)}
      it {should eq expected.to_json}
    end

    describe '#expression' do
      before {rule.build_expression(input)}
      its(:expression) {should eq expected}
    end
  end

  context 'private after_save callbacks' do
    before do
      @user = FactoryGirl.create :user
    end

    describe '#enqueue_build_share' do
      it 'should queue the build share job' do
        rule = FactoryGirl.build(:media_share_rule, :creator => @user)
        BuildMediaShareResqueQueue.should_receive(:enqueue).with(an_instance_of(Fixnum))
        rule.save
      end
    end

  end

end
