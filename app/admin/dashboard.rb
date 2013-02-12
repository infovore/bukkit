ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Latest Accounts" do
          table do
            tr do
              th "Number"
              th "Activated?"
              th "Items to be delivered"
              th "Items delivered"
            end
            Account.latest(5).map do |account|
              tr do
                td account.phone_number.truncate(9) if account.phone_number
                td account.activated? ? "Yes" : "No"
                td account.items.to_be_delivered.size
                td account.items.delivered.size
              end
            end
          end
          para link_to "View all accounts", admin_accounts_path
        end
      end
        
      column do
        panel "Statistics" do
          table do
            tr do
              th "Number of accounts"
              th "Number of items"
              th "Number of delivered items"
            end
            tr do
              th Account.all.size
              th Item.all.size
              th Item.delivered.size
            end
          end
        end
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
