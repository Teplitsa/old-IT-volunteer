# encoding: utf-8

module TasksHelper
  
  def task_apply_button(task)
    if task.user_role(current_user)
      content_tag :span, :id => "task-#{task.id}",
                  :class => "btn btn-small btn-warning disabled" do
        content_tag(:i, :class => 'icon-ok')
        'Вы ' + t("role.#{task.user_role(current_user).name}")
      end
    else
      link_to apply_task_path(task),
              :id     => "task-#{task.id}",
              :class  => "btn btn-small btn-warning" do
        content_tag(:i, :class => 'icon-ok')
        'Хочу попробовать'
      end
    end
  end

  def feedback(user)
    feedback = user.feedbacks.for_task(@task.id).first
    if feedback.blank? && can?(:feedback, @task)
      render 'feedback_form', :user => user
    else
      render 'users/user_rating', :user => user if feedback.present?
    end
  end

  def kick_role_task_path(role, user)
    method("kick_#{role}_task_path").call(:user_id => user.id)
  end

  def state_switcher
    html = Task::STATES.map do |act,val|
      if @task.method("#{val[:state]}?").call
        task_state
      else
        link_to(
          t("task.state.#{val[:state].to_s}"), change_state_task_path(@task, act),
          :class => "btn btn-mini #{@task.state == val[:value] ? 'active' : ''}", 
          :type => "button",
          :method => :put
        )
      end
    end.join.html_safe
  end

  def task_state
    state = Task::STATES.find{ |act, st| 
      st[:value] == @task.state 
    }[1][:state].to_s

    content_tag(:span, t("task.state.#{state}"), 
      :class => "btn btn-mini active #{state}"
    )
  end

  def task_state_name(state)
    case state
    when 1
      'opened'
    when 2
      'in_progress'
    when 3
      'closed'
    when 4
      'unpublished'
    end
  end

  def empty_tasks_table(tasks)
    html = []
    [1,2,3,4].each do |state|
      if !tasks.select{|s,t| s == state}.present?
        html << content_tag(:div, 
          t("none.task.state.#{task_state_name(state)}"),
          :class => "tab-pane #{state == 1 ? 'active': ''}", 
          :id => task_state_name(state)
        )
      end
    end
    html.join.html_safe
  end

  def tasks_page_title(params)
    if params[:is_free].present?
      case params[:is_free]
      when 't'
        'Бесплатные задачи'
      when 'f'
        'Платные задачи'
      end
    else
      'Задачи'
    end
  end

end
