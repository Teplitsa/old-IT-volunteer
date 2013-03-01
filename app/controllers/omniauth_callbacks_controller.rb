class OmniauthCallbacksController < Devise::OmniauthCallbacksController
SERVICES = %w(facebook)

  SERVICES.each do |service|
    define_method service do 
      omniauth = request.env['omniauth.auth']
      if current_user
        if auth = Authentication.find_or_create_by_uid_and_provider(:uid => omniauth['uid'],
                                                                    :provider => omniauth['provider'],
                                                                    :user_id => current_user.id)
          flash[:success] = "You have successfully added your #{service.capitalize} account!"
          redirect_to edit_user_profile_path
        end
      elsif (auth = Authentication.find_by_uid_and_provider(omniauth['uid'], omniauth['provider']))\
                    && !Authentication.find_by_uid_and_provider(omniauth['uid'], omniauth['provider']).user.nil?
        sign_in_and_redirect(:user, auth.user)
      elsif omniauth['info']['email'] && omniauth['info']['email'].length > 0 # wtf? yandex sets emty hash if no email
        if user = User.find_by_email(omniauth['info']['email'])
          user.apply_omniauth(omniauth)
        else
          user = User.build_user_wo_confirmation(omniauth)
          user.apply_omniauth(omniauth)
        end
        sign_in_and_redirect(:user, user)
      else
        user = User.build_user_wo_confirmation(omniauth)
        user.apply_omniauth(omniauth)
        if user.save
          sign_in_and_redirect :user, user
        else
          session['devise.omniauth'] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
    end
  end
  
end