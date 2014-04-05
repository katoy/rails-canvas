require 'test_helper'

class BrowserTest < ActionDispatch::IntegrationTest

  test 'Can access /' do
    visit '/'
  end
end
