# coding: utf-8
class AdminController < ApplicationController
  before_filter do |c|
    c.send(:check_access_level, User.manager_role)
  end

  def index
    @users = User.order("role,username")
  end

  def add_new_user
    pwd = nil
    use_random_pwd = false
    if params[:user]
      pwd = params[:user][:password]
      if pwd.nil? || pwd.length < 8
        pwd = SecureRandom.hex(8) # user will need to use the "forgot password" feature to set a useful password
        use_random_pwd = true
      end
      options = { username: params[:user][:username], email: params[:user][:email], password: pwd, password_confirmation: pwd, role: User.user_role } if params[:user]
      user = User.new(options)
      unless user.save
        @error_message = user.errors.full_messages.map { |s| s }.join('<br />') if user.errors
        @error_message ||= t(:cannot_save_new_user, scope: 'myinfo.errors.messages')
      end
      @error_message = "#{@error_message}<br />Use random string for password.(Because inputed password length < 8)" if use_random_pwd

    else
      @error_message ||= t(:cannot_save_new_user, scope: 'myinfo.errors.messages')
    end
    @users = User.order("role,username")
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render layout: false }
    end
  end

  def update_user
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.json { respond_with_bip(@user) }
    end
  end

  def delete_user
    @user = User.find(params[:id])
    @user.destroy if current_user.is_admin?
    @users = User.order("role,username")
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render layout: false }
    end
  end
end
