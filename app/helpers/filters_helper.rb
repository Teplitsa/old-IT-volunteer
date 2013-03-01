# encoding: utf-8

module FiltersHelper
  
  def select_prize_types(selected)
    prize_types = [['тип награды', nil]].concat PrizeType.all.map { |prize| [prize.name, prize.id] }

    select_tag :prizes, options_for_select(prize_types, selected), :class => 'filter-select'
  end

  def select_task_types(selected)
    task_types = [['тип задачи', nil]].concat TaskType.all.map { |type| [type.name, type.id] }

    select_tag :types,  options_for_select(task_types, selected), :class => 'filter-select'
  end

  def select_organization_types(selected)
    orgs_types = [['любые', nil], ['группы', true], ['организации', false]]

    select_tag :is_group,  options_for_select(orgs_types, selected), :class => 'filter-select'
  end

  def select_task_state(selected)
    states = Task::STATES.map do |act, st|
      [t("task.state.#{st[:state]}"), st[:value]]
    end
    select_tag :state,  options_for_select(states, selected), :class => 'filter-select'
  end

  
end