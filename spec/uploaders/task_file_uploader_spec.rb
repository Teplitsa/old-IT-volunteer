require 'spec_helper'
require 'carrierwave/test/matchers'

describe TaskFileUploader do
  include CarrierWave::Test::Matchers

  before(:all)   { TaskFileUploader.enable_processing = true }
  after(:all)    { TaskFileUploader.enable_processing = false }
  before(:each)  { uploader.store! File.open(uploaders_test_file) }

  let(:uploader) { TaskFileUploader.new(mock_model(User).as_null_object) }

  # describe 'the default version' do
  #   pending
  #   #it { uploader.should be_no_larger_than(230, 230) }
  # end

end