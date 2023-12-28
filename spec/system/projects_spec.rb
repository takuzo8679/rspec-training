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
    }.to change(user.projects, :count).by(1)

      aggregate_failures do
        expect(page).to have_content("Project was successfully created.")
        expect(page).to have_content("Test project")
        expect(page).to have_content("Trying Capybara")
        expect(page).to have_content("Owner: #{user.name}")
      end
  end

  scenario "user completes a project" do
    # プロジェクトを持ったユーザーが必要でそのユーザーはログインしている
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user)
    sign_in user

    # ユーザーはプロジェクト画面を開き
    visit project_path(project)

    # 完了後の文言が表示されていないことの確認
    expect(page).to_not have_content "Completed"

    # 完了(complete)ボタンをクリックする
    click_button "Complete"
    # プロジェクトは完了済み(completed)としてマークされる
    expect(project.reload.completed?).to be true
    expect(page).to have_content "Congratulations, this project is complete!"
    expect(page).to have_content "Completed"
    expect(page).to_not have_button "Complete"
  end
end
