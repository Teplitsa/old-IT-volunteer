namespace :grab do

  desc "Grab frelancim.ru content"
  task :tasks => :environment do 
    require 'mechanize'

    agent = Mechanize.new

    prize_types = PrizeType.all
    types = TaskType.all.map(&:id)
    users = User.all

    5.times do |i|
      page = agent.get("http://freelansim.ru/tasks?page=#{ i + 1 }")

      page.search('.task').each do |t|
        title = t.at('.title').text
        problem = t.at('.description').text

        type = types[rand(types.size)]
        user = users[rand(users.size)]

        prizes = prize_types.shuffle[1..3].map do |prize_type| 
          prize = {'prize_type_id' => prize_type.id}
          prize['count'] = rand(5) + 1 unless  prize_type.segregate
          prize
        end

        puts title
        org = Organization.new({name: "organization#{i}",
                                address: 'blabla blab lba',
                                website: "some-where.com",
                                verified: true},
                                without_protection: true)
        org.save

        user.add_role :representative, org

        begin 
          params =  {title: title[0...30], 
                  problem: (problem)[0...300],
                 deadline: (Time.now+10.day),
              task_prizes: prizes,
             task_type_id: type,
          organization_id: org.id}

          user.tasks.new(params).publish!
        rescue Exception => ex
          puts ex
          puts params
          raise ex
        end
      end
    end
  end

end