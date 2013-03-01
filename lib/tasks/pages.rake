# encoding: UTF-8
namespace :pages do
  
  PAGES = ['НКО и общественным инициативам', 'IT-волонтерам',
    'Профессиональным студиям'
  ]

  desc "Generate static pages"
  task :generate => :environment do
    I18n.locale = :ru

    PAGES.each do |page|
      Page.create(:title => page,
        :content => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit,
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. 
        Duis aute irure dolor in reprehenderit in voluptate velit
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupitat
        proident, sunt in culpa qui officia deserunt mollit anim id est labum.'
      )
    end

  end

end
