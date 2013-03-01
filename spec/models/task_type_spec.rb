require 'spec_helper'

describe TaskType do

  let(:task_type) { build :task_type }
  
  it { task_type.should be_accessible_only(:name, :image) }

  it 'is valid with valid attributes' do
    task_type.should be_valid
  end

  describe '#name' do
    it 'is required' do
      task_type.name = nil
      task_type.should have(2).error_on(:name)
    end

    it 'is length min 3' do
      task_type.name = 's'
      task_type.should have(1).error_on(:name)
    end

    it 'is length max 100' do
      task_type.name = 's' * 101
      task_type.should have(1).error_on(:name)
    end

    it 'is unique, case insensetive' do
      another_task_type = create(:task_type, name: task_type.name.upcase)
      task_type.should have(1).error_on(:name)
    end
  end

end
