require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  scenario "user toggle a task", js:true do
    # データ生成
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user, name: "Scenario Task")
    task = project.tasks.create!(name: 'Finish Rspec tutorial')
    # テスト画面まで移動
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button "Log in"
    click_link "Scenario Task"
    # テスト
    check "Finish Rspec tutorial"
    expect(page).to have_css "label#task_#{task.id}.completed"
    uncheck "Finish Rspec tutorial"
    expect(page).to_not have_css "label#task_#{task.id}.completed"
  end
end
