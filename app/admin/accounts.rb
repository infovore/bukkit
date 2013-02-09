ActiveAdmin.register Account do
  index(:download_links => false) do |account|
    selectable_column
    column :id
    column :phone_number do |a| 
      a.phone_number.truncate(2)
    end
    column :activation_code
    column :auth_token
    column :created_at
    column :updated_at
    default_actions
  end
  
end
