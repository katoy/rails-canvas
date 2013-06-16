module DeviseHelper
 
  # allow for flexible location of Devise forms
  def resource_name
    :user
  end
  def resource
    @resource ||= User.new
  end
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # override to make formatting more friendly
  def devise_error_messages!

    return "" if resource.errors.empty?
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    # empty out error messages so they don't linger
    resource.errors.clear  
    
    # remove close button option for now - CSS conflict with facebox
    html = <<-HTML
<div class="alert fade in alert-error">
<ul>#{messages}</ul>
</div>
HTML
    html.html_safe
  end
end
