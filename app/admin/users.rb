ActiveAdmin.register User do
  actions :all, except: [:new,:create,:destroy]

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
scope :all
scope :no_team
scope :tutor
scope :student

filter :team
filter :name
filter :univ, as: :select, collection: User.all.pluck("univ").uniq.sort
filter :year, as: :select, collection: User.all.pluck("year").uniq.sort
filter :role, as: :select, collection: User.all.pluck("role").uniq

index do
  selectable_column
  # id_column
  # column :lion_id
  column :year
  column :role
  column :univ
  column :name
  column :email
  column :team
  # column :memo
  # actions
end

end
