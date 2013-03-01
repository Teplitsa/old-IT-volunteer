# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|  
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :home, 'Главная', root_path do |sub_nav| 
      sub_nav.item :tasks, "#{tasks_page_title(params)}",
                   tasks_path(:is_free => (params[:is_free] if params[:is_free].present?)) do |task|
        if @task.present?
          if @task.persisted?
            task.item :task, @task.title, task_path(@task)
          elsif @task.new_record?
            task.item :task, 'Новая задача', new_task_path    
          end
        end
      end
      sub_nav.item :organizations, 'Организации', organizations_path do |org|
        if @organization.present?
          if @organization.persisted?
            org.item :org, @organization.name, organization_path(@organization)
          elsif @organization.new_record?
            org.item :org, 'Новая организация', new_organization_path
          end
        end
      end
      sub_nav.item :users, 'Пользователи', users_path do |user|
        if @user.present?
          user.item :user, @user.to_s, user_path(@user)
        end
      end
    end
    primary.dom_class = 'breadcrumb-list'
    navigation.autogenerate_item_ids = false
  end
end
