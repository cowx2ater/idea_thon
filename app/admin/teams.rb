ActiveAdmin.register Team do
  actions :all, except: [:new,:create,:edit,:update,:destroy]

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
# controller do
#   def scoped_collection
#     super.includes(:teams).select '*, count(t.*) as author_count'
#   end
# end
config.sort_order = 'cnt_desc'

index do
  selectable_column
  # id_column
  column :rank do |team|
    total_ary = Team.all.pluck("cnt")
    sorted = total_ary.sort.uniq.reverse
    p sorted.index(team.cnt) + 1
  end
  column :cnt
  column :name
  column :desc
  column :url do |team|
    link_to("보러가기",team.url)
  end
  # column :memo
  actions
end

end
