# encoding: utf-8

ActiveAdmin.register Task do
  menu :priority => 1

  config.per_page = 10
  
  scope :all, default: true
  scope :free
  scope :paid

  filter :id
  filter :title
  filter :deadline
  filter :task_type, as: :check_boxes 

  index do
    column :id
    column :title
    
    column :task_type do |task|
      task.task_type.name
    end

    column :state do |task|
      task.state_name
    end

    column :deadline
    
    column :prizes do |task|
      ul do
        task.task_prizes.includes(:prize_type).each do |task_prize|
          if task_prize.prize_type
            li do
              s = task_prize.prize_type.name
              s += "(" + task_prize.count.to_s + ")" unless task_prize.prize_type.segregate
              s
            end
          end
        end
      end
    end

    default_actions                   
  end                                     

  form do |f|                         
    f.inputs "Task Details" do
      f.input :organization, :collection => Organization.all.map{|u| [u.name, u.id]}
      f.input :owner,        :collection => User.all.map{|u| [u.full_name, u.id]}
      f.input :title
      f.input :problem
      f.input :deadline, :as => :datepicker
      # f.input :task_prizes, as: :check_box, collection: PrizeType.all.map { |prize| [prize.name, prize.id] }
      f.input :task_type,   as: :select, collection: TaskType.all.map { |type| [type.name, type.id] }
    end      

    f.inputs "Task filles" do
      f.input :image
      f.input :file
    end                         
    
    f.buttons                         
  end

  show do |task|
    h3 task.title
    
    attributes_table do
      row :task_type do |t|
        t.task_type.name
      end

      row :problem
      row :deadline

      row :prizes do |t|
         task.task_prizes.includes(:prize_type).map do |task_prize|
        
      end.join
        ul do
          t.task_prizes.each do |task_prize|
            li do
              s = task_prize.prize_type.name
              s += "(" + task_prize.count.to_s + ")" unless task_prize.prize_type.segregate
              s
            end
          end
        end
      end

      if task.file.present?
        row :file do |t|
          link_to 'attached file', t.file.url if t.file.present?
        end
      end

      if task.file.present?
        row :image do |t|
          image_tag t.image.url if t.image.present?
        end
      end

    end
  end
                       
end                                   
