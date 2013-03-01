ActiveAdmin.register Organization do

  scope :all, :default => true do |orgs|
    orgs
  end

  filter :name
  filter :verified, as: :select
  filter :email
  filter :inn
  filter :kpp
  filter :website
  # filter :slug
  # filter :skype
  # filter :twitter
  # filter :facebook
  # filter :linkedin

  index do
    selectable_column
    # column :id
    column :name
    column :verified do |org|
      if org.verified
        link_to 'unverify',  unverify_admin_organization_path(org), method: :put
      else
        link_to 'verify', verify_admin_organization_path(org), method: :put
      end
    end
    column :email
    column :website
    default_actions
  end

  member_action :verify, :method => :put do
    org = Organization.find(params[:id])
    org.verify!
    redirect_to({:action => :index}, notice: "Verified organization!")
  end

  member_action :unverify, :method => :put do
    org = Organization.find(params[:id])
    org.unverify!
    redirect_to({:action => :index}, notice: "Unerified organization!")
  end

  controller do
    def update
      @organization = Organization.find(params[:id])
      @organization.update_attributes(params[:organization], :without_protection => true)
      redirect_to admin_organization_path(@organization), :notice => 'Successfuly updated!'
    end
  end  

end