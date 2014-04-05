require 'test_helper'

# Placeholder:
# need to integrate behavoir driven integration testing that handles the AJAX devise forms
# possilibity is https://github.com/thoughtbot/capybara-webkit ?
#

class DeviseTest < ActionDispatch::IntegrationTest

  test 'home should be accessible without sign in' do
    get '/'
    assert_response :success
    assert_select 'title', 'home:&nbsp;SampleApp'
  end

  test 'valid user login' do
    post '/users/sign_in', user: { username: 'fred', password: '123123' }
    assert_response :success
  end

  test 'invalid password login' do
    post '/users/sign_in', user: { username: 'fred', password: 'xxxxxx' }, format: 'js'
    # assert that the response code was status code 401 (unauthorized)
    assert_response 401
  end

  test 'invalid user login' do
    post '/users/sign_in', user: { username: 'xxxxxxx', password: '123123' }, format: 'js'
    # assert that the response code was status code 401 (unauthorized)
    assert_response 401
  end

  test 'user_02 can not login' do
    post '/users/sign_in', user: { username: 'user_02', password: '123123' }, format: 'js'
    # assert that the response code was status code 401 (unauthorized)
    assert_response 401
  end

  test 'user_01 can login' do
    post '/users/sign_in', user: { username: 'user_01', password: '123123' }
    assert_response :success
  end

end
