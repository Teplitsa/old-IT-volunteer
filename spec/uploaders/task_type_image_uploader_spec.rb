require 'spec_helper'
require 'carrierwave/test/matchers'

describe TaskTypeImageUploader do
  include CarrierWave::Test::Matchers

  before(:all)   { TaskTypeImageUploader.enable_processing = true }
  after(:all)    { TaskTypeImageUploader.enable_processing = false }
  before(:each)  { uploader.store! File.open(uploaders_test_file) }

  let(:uploader) { TaskTypeImageUploader.new(mock_model(User).as_null_object) }

  describe 'the default version' do
    it { uploader.should be_no_larger_than(80, 80) }
  end

end