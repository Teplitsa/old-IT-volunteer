require 'spec_helper'
require 'carrierwave/test/matchers'

describe PrizeImageUploader do
  include CarrierWave::Test::Matchers

  before(:all)   { PrizeImageUploader.enable_processing = true }
  after(:all)    { PrizeImageUploader.enable_processing = false }
  before(:each)  { uploader.store! File.open(uploaders_test_file) }

  let(:uploader) { PrizeImageUploader.new(mock_model(User).as_null_object) }

  describe 'the default version' do
    it { uploader.should be_no_larger_than(100, 100) }
  end

end