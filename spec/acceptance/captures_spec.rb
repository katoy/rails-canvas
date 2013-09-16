# -*- coding: utf-8 -*-
require 'spec_helper'

SCRENNSHOT_DIR = './tmp/screenshot'

feature "Home" do

  fixtures :users

  before do
    Capybara.current_driver = :poltergeist
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, :js_errors => false, :timeout => 60, :debug => false)
    end
  end

  after do
    #Capybara.current_driver = :rack_test
    Capybara.use_default_driver
  end

  scenario "visit without login",  :js => true do
    visit root_path
    save_screenshot("#{SCRENNSHOT_DIR}/without_login_001_root.png", :full => true)
    visit dashboard_path
    save_screenshot("#{SCRENNSHOT_DIR}/without_login_002_dashboard.png", :full => true)
    visit pictures_path
    save_screenshot("#{SCRENNSHOT_DIR}/without_login_003_pictures.png", :full => true)
    visit messages_path
    save_screenshot("#{SCRENNSHOT_DIR}/without_login_004_messages.png", :full => true)
    visit admin_path
    save_screenshot("#{SCRENNSHOT_DIR}/without_login_005_admin.png", :full => true)
    visit help_path
    save_screenshot("#{SCRENNSHOT_DIR}/wothout_login_006_help.png", :full => true)
  end

  scenario "capture with login",  :js => true do
    @admin = users(:admin)
    login @admin

    visit root_path
    save_screenshot("#{SCRENNSHOT_DIR}/capture_001_root.png", :full => true)
    visit dashboard_path
    save_screenshot("#{SCRENNSHOT_DIR}/capture_002_dashboard.png", :full => true)
    visit pictures_path
    save_screenshot("#{SCRENNSHOT_DIR}/capture_003_pictures.png", :full => true)
    visit messages_path
    save_screenshot("#{SCRENNSHOT_DIR}/capture_004_messages.png", :full => true)
    visit admin_path
    save_screenshot("#{SCRENNSHOT_DIR}/capture_005_admin.png", :full => true)
    visit help_path
    save_screenshot("#{SCRENNSHOT_DIR}/capture_006_help.png", :full => true)
  end

  scenario "visit login form",  :js => true do
    visit new_user_session_path
    expect(find_link("ログイン")).not_to eq(nil)

    fill_in "user[username]", :with => "admin"
    fill_in "user[password]", :with => "123123"
    save_screenshot("#{SCRENNSHOT_DIR}/login_form-01.png", :full => true)

    find_button("ログイン").click
    sleep(1.0)
    save_screenshot("#{SCRENNSHOT_DIR}/login_form-02.png", :full => true)

    expect(find_link("admin")).not_to eq(nil)
    expect(find_link("ログアウト")).not_to eq(nil)
    find_link("ログアウト").click
    sleep(1.0)
    save_screenshot("#{SCRENNSHOT_DIR}/login_form-03.png", :full => true)
  end

end
