require 'rails_helper'

RSpec.describe "Projects", type: :system do
  # support moduleの読み込み
  include LoginSupport
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
    sign_in user
    # 本来ログイン後に遷移するはずの画面に移動
    visit root_path

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
