ActiveAdmin.register PrizeType do 

  scope :all, :default => true do |prize_types|
    prize_types
  end

  scope :segregated do |prize_types|
    prize_types.segregated
  end

  scope :not_segregated do |prize_types|
    prize_types.not_segregated
  end

  index do                            
    column :name
    column :is_free
    column :image do |type|
      image_tag type.image.url if type.image.present?
    end
    
    default_actions                   
  end                                 

  config.filters = false           

  form do |f|                         
    f.inputs "Prize details" do       
      f.input :name
      f.input :segregate         
      f.input :image
    end
                                   
    f.buttons                         
  end

  show do |type|
    attributes_table do
      row :name do 
        type.name
      end
      row :segregate do
        type.segregate
      end
      row :image do
        image_tag type.image.url if type.image.present?
      end
    end
  end
                            
end                                   
