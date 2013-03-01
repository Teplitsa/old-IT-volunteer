require 'spec_helper'

describe Prize do
  
  let(:prize) { build :prize }
  
  it { prize.should be_accessible_only(:name, :image, :segregate) }

  it 'is valid with valid attributes' do
    prize.should be_valid
  end

  describe '#name' do
    it 'is required' do
      prize.name = nil
      prize.should have(2).error_on(:name)
    end

    it 'is length min 3' do
      prize.name = 's'
      prize.should have(1).error_on(:name)
    end

    it 'is length max 100' do
      prize.name = 's' * 101
      prize.should have(1).error_on(:name)
    end

    it 'is unique, case insensetive' do
      another_prize = create(:prize, name: prize.name.upcase)
      prize.should have(1).error_on(:name)
    end
  end

end
