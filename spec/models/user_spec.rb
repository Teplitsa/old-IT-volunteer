require 'spec_helper'

describe ::User do

  let(:user) { build :user }

  it { user.should be_accessible_only(:about, 
                                      :avatar, 
                                      :avatar_cache, 
                                      :email, 
                                      :first_name, 
                                      :last_name, 
                                      :password, 
                                      :password_confirmation, 
                                      :remember_me, 
                                      :remote_avatar_url, 
                                      :sex) }

  it 'is valid with valid attributes' do
    user.should be_valid
  end

  describe '#first_name' do
    it 'is not required' do
      user.first_name = nil
      user.should_not have(1).error_on(:first_name)
    end
  end

  describe '#last_name' do
    it 'is not required' do
      user.last_name = nil
      user.should_not have(1).error_on(:last_name)
    end
  end

  describe '#email' do
    it 'is required' do
      user.email = nil
      user.should have(1).error_on(:email)
    end

    it 'is unique' do
      another_user = create(:user, email: user.email)
      user.should have(1).error_on(:email)
    end
  end

  describe '#sex' do
    it 'is not required' do
      user.sex = nil
      user.should_not have(1).error_on(:sex)
    end
  end

end



   