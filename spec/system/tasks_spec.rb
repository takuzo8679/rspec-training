require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  include LoginSupport
  scenario "user toggle a task", js:true do
    # データ生成
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user, name: "Scenario Task")
    task = project.tasks.create!(name: 'Finish Rspec tutorial')
    # テスト画面まで移動
    sign_in_as(user)
    click_link "Scenario Task"
    # テスト
    check "Finish Rspec tutorial"
    expect(page).to have_css "label#task_#{task.id}.completed"
    uncheck "Finish Rspec tutorial"
    expect(page).to_not have_css "label#task_#{task.id}.completed"
  end
end
