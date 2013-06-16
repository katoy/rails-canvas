class LocalDevise::SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failed_login")
    sign_in(resource_name, resource)   
    set_msg t(:signed_in, :scope => 'devise.sessions')
    log_sign_in
    respond_to do |format|
      format.js
      # and now keep placeholder integration test happy
      format.html {render :nothing => true, :status => 200, :content_type => 'text/html'}
    end
  end

  def failed_login
    set_msg t(:invalid, :scope => 'devise.failure')   
  end
end
