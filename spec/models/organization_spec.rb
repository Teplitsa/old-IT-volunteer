require 'spec_helper'

describe Organization do
  
  let(:organization) { build :organization }
  
  it { organization.should be_accessible_only(:about, :inn, :kpp, :logo, :logo_cache, :name, :property_type, :website, :user_id) }

  it 'is valid with valid attributes' do
    organization.should be_valid
  end

  describe '#about' do
    it 'is not required' do
      organization.about = nil
      organization.should be_valid
    end
  end

  describe '#inn' do
    it 'is not required' do
      organization.inn = nil
      organization.should be_valid
    end
  end

  describe '#kpp' do
    it 'is not required' do
      organization.kpp = nil
      organization.should be_valid
    end
  end

  describe '#name' do
    it 'is required' do
      organization.name = nil
      organization.should have(2).error_on(:name)
    end

    it 'is length min 3' do
      organization.name = 's'
      organization.should have(1).error_on(:name)
    end

    it 'is length max 100' do
      organization.name = 's' * 101
      organization.should have(1).error_on(:name)
    end

    it 'is unique, case insensetive' do
      another_organization = create(:organization, name: organization.name.upcase)
      organization.should have(1).error_on(:name)
    end
  end

  describe '#property_type' do
    it 'is not required' do
      organization.property_type = nil
      organization.should be_valid
    end
  end

end
