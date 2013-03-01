require 'spec_helper'
require 'carrierwave/test/matchers'

describe LogoUploader do
  include CarrierWave::Test::Matchers

  before(:all)   { LogoUploader.enable_processing = true }
  after(:all)    { LogoUploader.enable_processing = false }
  before(:each)  { uploader.store! File.open(uploaders_test_file) }

  let(:uploader) { LogoUploader.new(mock_model(User).as_null_object) }

  describe 'the default version' do
    it { uploader.should be_no_larger_than(230, 230) }
  end

end