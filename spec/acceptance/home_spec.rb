require 'spec_helper'

feature "Home" do
  before do
    Capybara.current_driver = :poltergeist
  end

  scenario "visit root" do
    visit root_path
    save_screenshot('./tmp/screenshot/root_001.png')
  end

   after do
    Capybara.current_driver = :rack_test
   end
end
