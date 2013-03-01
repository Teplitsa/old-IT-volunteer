# encoding: utf-8

module OrganizationsHelper

  def join_organization_button(organization)
    if current_user.has_any_role?({:name => :member, :resource => organization},
                                  {:name => :representative, :resource => organization})
      link_to 'Покинуть', "#", :class => 'btn btn-mini btn-block'
    else
      link_to 'Вступить', "#", :class => 'btn btn-mini btn-block btn-warning'
    end
  end

end
