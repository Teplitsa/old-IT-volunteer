require 'spec_helper'

describe Task do

  let(:task) { build :task }
  
  it { task.should be_accessible_only(:title, :problem, :solution, :deadline, :location, :prize_id, :task_type_id, :image, :file) }

  it 'is valid with valid attributes' do
    task.should be_valid
  end

  describe '#title' do
    it 'is required' do
      task.title = nil
      task.should have(2).error_on(:title)
    end

    it 'is length min 2' do
      task.title = 's'
      task.should have(1).error_on(:title)
    end

    it 'is length max 100' do
      task.title = 's' * 101
      task.should have(1).error_on(:title)
    end
  end

  describe '#problem' do
    it 'is required' do
      task.problem = nil
      task.should have(2).error_on(:problem)
    end

    it 'is length min 10' do
      task.problem = 's'
      task.should have(1).error_on(:problem)
    end

    it 'is length max 300' do
      task.problem = 's' * 301
      task.should have(1).error_on(:problem)
    end
  end

  describe '#solution' do
    it 'is required' do
      task.solution = nil
      task.should have(2).error_on(:solution)
    end

    it 'is length min 10' do
      task.solution = 's'
      task.should have(1).error_on(:solution)
    end

    it 'is length max 300' do
      task.solution = 's' * 301
      task.should have(1).error_on(:solution)
    end
  end

  describe '#deadline' do
    it 'is required' do
      task.deadline = nil
      task.should have(2).error_on(:deadline)
    end

    it 'is at least the beginning of the next day' do
      task.deadline = Time.now.beginning_of_day
      task.should have(1).error_on(:deadline)
    end
  end

  describe 'states' do

    describe 'opened' do
      let(:task) { build :task, state: 1 }

      it 'is initial state' do
        build(:task).opened?.should be_true
      end

      it 'is a transition to in_progress' do
        task.perform!
        task.in_progress?.should be_true
      end

      it 'is a transition to close' do
        task.close!
        task.closed?.should be_true
      end
    end

    describe 'in_progress' do
      let(:task) { build :task, state: 2 }

      it 'is a transition to closed' do
        task.close!
        task.closed?.should be_true
      end

    end

    describe 'closed' do
      let(:task) { build :task, state: 3 }

      it 'is not a transition to in_progress' do
        lambda {task.perform!}.should raise_error StateMachine::InvalidTransition
      end
    end

  end

end
