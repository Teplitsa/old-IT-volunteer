class RegistrationsController < Devise::RegistrationsController

  private

  def build_resource(*args)
    super
    
    if session['devise.omniauth']
      @user.apply_omniauth(session['devise.omniauth'])
      @user.valid?
    end
  end

end