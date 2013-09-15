
module ControllerMacros
  def login_user
    before(:each) do
      # @request.env["devise.mapping"] = Devise.mappings[:admin]
      # sign_in Factory.create(:admn)
      # @admin = users(:admin)
      # sign_in :user, @admin
    end
  end
end
