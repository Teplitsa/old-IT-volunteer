namespace :fake do

  desc "Generate fake messages"
  task :messages => :environment do 
    User.all.combination(2).each do |(sender, receiver)|

      (1..(rand(10))).each do |di| # dialogs
        first_message = sender.send_messages.create! body: Faker::Lorem.paragraph, 
                                              receiver_id: receiver.id

        (1..(rand(20))).each do |mi| # messages
          first_message = sender.send_messages.create! dialog_id: first_message.dialog_id, 
                                                            body: Faker::Lorem.paragraph,
                                                     receiver_id: receiver.id
        end
      end

    end
  end

end