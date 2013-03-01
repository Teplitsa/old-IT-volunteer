require 'spec_helper'

describe Comment do

  let(:comment) { build :comment }
  
  it { comment.should be_accessible_only(:body) }

  it 'is valid with valid attributes' do
    comment.should be_valid
  end

  describe '#body' do
    it 'is required' do
      comment.body = nil
      comment.should have(2).error_on(:body)
    end

    it 'is length min 2' do
      comment.body = 's'
      comment.should have(1).error_on(:body)
    end

    it 'is length max 1488' do
      comment.body = 's' * 1489
      comment.should have(1).error_on(:body)
    end
  end

end
