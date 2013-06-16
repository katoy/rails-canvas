class LocalDevise::RegistrationsController < Devise::RegistrationsController

# NOTE: some functionality has been removed for this project - check parent controller

  def create
    build_resource
    resource.role = User.user_role
    
    if resource.save
      sign_in(resource_name, resource)
      log_sign_in
      set_msg t(:signed_up, :scope => 'devise.registrations')
    else
      clean_up_passwords resource
      respond_to do |format|
        format.js { render :action => "failed_new" }
      end
    end
  end
  
  # Comment from Devise parent controller: 
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(resource_params)
      sign_in resource_name, resource, :bypass => true
      set_msg t(:updated, :scope => 'devise.registrations')
    else
      clean_up_passwords resource
      respond_to do |format|
        format.js { render :action => "failed_edit" }
      end
    end
  end 
end
