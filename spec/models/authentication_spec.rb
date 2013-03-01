require 'spec_helper'

describe Authentication do
  
  let(:authentication) { build :authentication }
  
  it { authentication.should be_accessible_only(:provider, :uid) }

  it 'is valid with valid attributes' do
    authentication.should be_valid
  end

  describe '#provider' do
    it 'is required' do
      authentication.provider = nil
      authentication.should have(1).error_on(:provider)
    end
  end

  describe '#uid' do
    it 'is required' do
      authentication.uid = nil
      authentication.should have(1).error_on(:uid)
    end

    it 'is unique, case insensetive' do
      another_authentication = create(:authentication, uid: authentication.uid.to_s.upcase)
      authentication.should have(1).error_on(:uid)
    end
  end

end