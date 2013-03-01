require 'spec_helper'
require 'carrierwave/test/matchers'

describe TaskImageUploader do
  include CarrierWave::Test::Matchers

  before(:all)   { TaskImageUploader.enable_processing = true }
  after(:all)    { TaskImageUploader.enable_processing = false }
  before(:each)  { uploader.store! File.open(uploaders_test_file) }

  let(:uploader) { TaskImageUploader.new(mock_model(User).as_null_object) }

  describe 'the default version' do
    it { uploader.should be_no_larger_than(200, 300) }
  end

  describe 'the thumb version' do
    it { uploader.thumb.should have_dimensions(100, 100) }
  end
  
end