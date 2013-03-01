ActiveAdmin.register TaskType do     
  index do                            
    column :name

    column :image do |type|
      image_tag type.image.url if type.image.present?
    end          
    
    default_actions                   
  end                                 

  config.filters = false                     

  form do |f|                         
    f.inputs "Task type details" do       
      f.input :name                  
      f.input :image
    end                               
    f.buttons                         
  end

  show do |type|
    attributes_table do
      row :name do 
        type.name
      end
      row :image do
        image_tag type.image.url if type.image.present?
      end
    end
  end
                         
end                                   
