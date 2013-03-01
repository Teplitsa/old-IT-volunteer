# encoding: utf-8

module MessagesHelper

  def collocutor(message)
    message.sender == current_user ? message.receiver : message.sender
  end

  def new_message_link(receiver, title='new message', target='#new_message')
    link_to title, '', 'class' => 'btn btn-success btn-block', 
                   'data-toggle' => :modal, 
                   'data-target' => target
  end

  def ignore_or_unignore_link(collocutor)
    content_tag :div, class: 'pull-right' do
      if not current_user.ignored?(collocutor)
        link_to 'заблокировать', ignore_user_path(collocutor), class: "ignore_or_unignore_link_#{ collocutor.id } btn btn-mini btn-warning", method: :put, confirm: 'уверен?', remote: true
      else
        link_to 'разблокировать', unignore_user_path(collocutor), class: "ignore_or_unignore_link_#{ collocutor.id } btn btn-mini btn-success", method: :put, confirm: 'уверен?', remote: true
      end
    end
  end

end
