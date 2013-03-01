# encoding: utf-8

module ApplicationHelper

  # For display a custom sign_in form anywhere in your app
  # https://github.com/plataformatec/devise/wiki/How-To:-Display-a-custom-sign_in-form-anywhere-in-your-app
  # We're use it from modal windows on home page

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def link_to_next_page(scope, name, options = {}, &block)
    param_name = options.delete(:param_name) || Kaminari.config.param_name
    link_to_unless scope.last_page?, name, params.merge(param_name => (scope.current_page + 1)), options.merge(:rel => 'next') do
      block.call if block
    end
  end

  def render_errors(object)
    if object.errors.any?
      
      content_tag :div, id: :error_explanation do
        content_tag(:h2, "#{pluralize(object.errors.count, "error")}") +
        content_tag(:ul) do
          object.errors.full_messages.map { |m| content_tag(:li, m) }.join.html_safe
        end
      end

    end
  end

  def user_organizations_options
   [['от своего имени', nil]].concat current_user.all_organizations.map { |org| [org.name, org.id] }
  end

end
