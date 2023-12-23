require 'rails_helper'

RSpec.describe "Projects", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "user creates a new project" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect {
      click_link "New Project"
      fill_in "Name", with: "Test project"
      fill_in "Description", with: "Trying Capybara"
      click_button "Create Project"

      expect(page).to have_content("Project was successfully created.")
      expect(page).to have_content("Test project")
      expect(page).to have_content("Trying Capybara")
      expect(page).to have_content("Owner: #{user.name}")
    }.to change(user.projects, :count).by(1)
  end
  # # デバッグ用save_pageの確認用テスト
  # scenario "guest add a project" do
  #   visit projects_path
  #   save_page
  #   save_and_open_page
  #   click_link "New Project"
  # end
end
