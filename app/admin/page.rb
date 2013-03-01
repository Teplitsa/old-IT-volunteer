ActiveAdmin.register Page do

  index do
    selectable_column
    # column :id
    column :title
    column :slug
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
    end
    f.buttons
  end

end