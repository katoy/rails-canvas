class FaceboxController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:fb_login, :fb_create_user]

# facebox stub functions
# real work is done in JS.ERB files under views/facebox
# or if not JS, then views under views/devise

  def fb_edit_user
  end

  def fb_create_user
  end

  def fb_login
  end

  def fb_reset_password
  end

end
