# encoding: utf-8

User.delete_all
Organization.delete_all
Task.delete_all
Role.delete_all

admin = User.create! about: 'bla bla', first_name: 'admin', last_name: 'god', email: 'admin@example.com', password: '123456', password_confirmation: '123456'
admin.add_role :admin

10.times { |i| User.create! about: 'bla bla', first_name: "fake#{ i }", last_name: 'test', email: "fake#{ i }@test.com", password: '123456', password_confirmation: '123456' }

User.all.each &:confirm!

PrizeType.delete_all

PrizeType.create name: 'Упоминание на сайте',  segregate: false, is_free: true
PrizeType.create name: 'Ссылка на сайт',       segregate: false, is_free: true
PrizeType.create name: 'Рекомендация друзьям', segregate: true,  is_free: true
PrizeType.create name: 'Ужин с руководителем', segregate: true,  is_free: true
PrizeType.create name: 'Сладости',             segregate: true,  is_free: true
PrizeType.create name: 'Пиво',                 segregate: true,  is_free: true
PrizeType.create name: 'Футболка',             segregate: true,  is_free: true
PrizeType.create! name: 'Наличка',              segregate: false, is_free: false
PrizeType.create! name: 'WEB Money',            segregate: false, is_free: false
PrizeType.create! name: 'ЯД',                   segregate: false, is_free: false
PrizeType.create! name: 'Bitcoin',              segregate: false, is_free: false

TaskType.delete_all

TaskType.create name: 'Помощь в соц.сетях'
TaskType.create name: 'Мелкие правки по сайту'
TaskType.create name: 'Новый сайт'
TaskType.create name: 'Помощь с видео'
TaskType.create name: 'Другое'