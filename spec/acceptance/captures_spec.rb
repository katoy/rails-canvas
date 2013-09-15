require 'spec_helper'

feature "Home" do

  fixtures :users

  before do
    Capybara.current_driver = :poltergeist
  end

  after do
    Capybara.current_driver = :rack_test
  end


  scenario "visit without login" do
    visit root_path
    save_screenshot('./tmp/screenshot/without_login_001_root.png')

    visit dashboard_path
    save_screenshot('./tmp/screenshot/without_login_002_dashboard.png')
    visit pictures_path
    save_screenshot('./tmp/screenshot/without_login_003_pictures.png')
    visit messages_path
    save_screenshot('./tmp/screenshot/without_login_004_messages.png')
    visit fb_edit_user_path
    save_screenshot('./tmp/screenshot/without_login_005_edit.png')

  end

  scenario "capture with login" do

   @admin = users(:admin)
   login @admin

    visit root_path
    save_screenshot('./tmp/screenshot/capture_001_root.png')

    visit dashboard_path
    save_screenshot('./tmp/screenshot/capture_002_dashboard.png')
    visit pictures_path
    save_screenshot('./tmp/screenshot/capture_003_pictures.png')
    visit messages_path
    save_screenshot('./tmp/screenshot/capture_004_messages.png')
    visit fb_edit_user_path
    save_screenshot('./tmp/screenshot/capture_005_edit.png')

  end

end
