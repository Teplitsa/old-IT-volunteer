# encoding: utf-8
class TaskMailer < ActionMailer::Base
  helper :events
  default from: Settings.mail_from

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.task_mailer.updates.subject
  #
  def updates(event)
    @user = event.user
    @task = event.target
    @event = event
    @url = url_for(controller: "tasks", action:"show", 
                   only_path: false, id: @task.id)

    mail to: @user.email, subject: 'Ваша задача обновлена.'
  end
end
