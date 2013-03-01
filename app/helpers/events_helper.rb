# encoding: utf-8

module EventsHelper
  def roleEventMessage(event)
    if event.action.to_s == 'add'
      "#{event.user} присоединился к задаче"
    else
      "#{event.user} прекратил участие в задаче"
    end
  end

  def taskEventMessage(event)
    case event.message
    when 'created'
      "#{event.user} Создал задачу."
    when 'updated'
      "#{event.user} Обновил задачу."
    when 'opened'
      "#{event.user} Открыл задачу."
    when 'closed'
      "Задача закрыта"          
    end
  end
end
