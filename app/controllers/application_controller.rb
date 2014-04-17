# coding: utf-8
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery
  helper_method :current_msg, :set_msg, :clear_msg, :is_msg?


  # See http://morizyun.github.io/blog/custom-error-404-500-page/
  # Railsの404/500エラーページ、簡単作成手順

  # 例外ハンドル
  rescue_from ::ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ::AbstractController::ActionNotFound, :with => :render_404
  rescue_from ::ActionController::RoutingError, :with => :render_404
  rescue_from Exception, :with => :render_500

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render :template => "errors/error_404", :status => 404, :layout => 'application', :content_type => 'text/html'
  end

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render :template => "errors/error_500", :status => 500, :layout => 'application', :content_type => 'text/html'
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    dashboard_path
  end

  def check_access_level(role)
    redirect_to dashboard_path unless current_user.role_access?(role)
  end

  # for passing around flash messages to/from js.erb
  def current_msg
    return session[:msg] if defined?(session[:msg])
    ''
  end

  def set_msg(str)
    session[:msg] = str
  end

  def clear_msg
    session[:msg] = ''
  end

  def is_msg?
    return true if session[:msg] && session[:msg].length > 0
    false
  end

  def log_sign_in(user = current_user)
    if user
      filename = Rails.root.join('log', 'login_history.log')
      sign_in_time = user.current_sign_in_at ? user.current_sign_in_at : Time.now
      File.open(filename, 'a') { |f| f.write("#{sign_in_time.strftime("%Y-%m-%dT%H:%M:%S%Z")} #{user.current_sign_in_ip} #{user.username} #{user.email if user.email} #{user.provider if user.provider}\n") }
    end
  end
end
