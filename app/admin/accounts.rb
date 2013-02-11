ActiveAdmin.register Account do
  index(:download_links => false) do |account|
    selectable_column
    column :id
    column :phone_number do |a| 
      a.phone_number.truncate(9) if a.phone_number
    end
    column "Items to be published" do |a|
      account.items.undelivered.size
    end
    column "Delivered items" do |a|
      account.items.delivered.size
    end
    column :activation_code
    column :auth_token do |a|
      a.auth_token.truncate(10) if a.auth_token
    end
    column :created_at
    column :updated_at
    column do |a|
      link_to "Preview this bukkit", items_path(:auth_token => a.auth_token, :preview => true)
    end
  end
  
end
