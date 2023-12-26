require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  include LoginSupport
  # データ生成
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user, name: "Scenario Task") }
  let!(:task) { project.tasks.create!(name: 'Finish Rspec tutorial') }

  scenario "user toggle a task", js:true do
    sign_in user
    go_to_project

    complete_task "Finish Rspec tutorial"
    expect_complete_task "Finish Rspec tutorial"
    uncomplete_task "Finish Rspec tutorial"
    expect_uncomplete_task "Finish Rspec tutorial"
  end

  def go_to_project
    visit root_path
    click_link "Scenario Task"
  end
  def complete_task(name)
    check name
  end
  def uncomplete_task(name)
    uncheck name
  end
  def expect_complete_task(name)
    expect(page).to have_css "label.completed", text: name
    expect(task.reload).to be_completed
  end
  def expect_uncomplete_task(name)
    expect(page).to_not have_css "label.completed", text: name
    expect(task.reload).to_not be_completed
  end
end
