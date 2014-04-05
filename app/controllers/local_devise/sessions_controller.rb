# coding: utf-8
class LocalDevise::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!

  def create
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failed_login")
    sign_in(resource_name, resource)
    set_msg t(:signed_in, scope: 'devise.sessions')

    # debugger
    # role 専用の login コントロールを作ることも可能
    # if resource.username == params[:role]
    #  log_sign_in
    # end
    log_sign_in

    respond_to do |format|
      format.js
      # and now keep placeholder integration test happy
      format.html { render nothing: true, status: 200, content_type: 'text/html' }
    end
  end

  def failed_login
    set_msg t(:invalid, scope: 'devise.failure')
  end
end
