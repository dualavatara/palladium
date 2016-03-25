module CompaniesHelper
  def edit_field(builder, field, label, placeholder='')
    html = '<div class="form-group">'
    html += builder.label field, label
    html += builder.text_field field, class: "form-control", placeholder: placeholder
    if builder.object.errors.full_messages_for(field).any?
      builder.object.errors.full_messages_for(field).each do |message|
        html += '<p class="text-danger"><small>' + message + '</small></p>'
      end
    end
    html += '</div>'
    raw html
  end

  def is_admin?(user, company)
    company.admin?(user)
  end

  def role_names(user, company)
    user.roles.for(company).pluck(:name)
  end

  def destroyable?(company)
    company.destroyable?
  end
end
