namespace :tasks do

  desc "Close with overdue deadline"
  task :close_overdeadline => :environment do 
    Task.where('deadline <= ?', DateTime.now).find_each do |t|
      p "closing #{t.id} #{t.deadline}"
      t.close
    end
  end


end
