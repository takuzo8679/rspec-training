require 'rails_helper'

RSpec.describe "SignIns", type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    # ActiveJobマッチャを使用するための宣言
    ActiveJob::Base.queue_adapter = :test
  end

  scenario "user signs in" do
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect { GeocodeUserJob.perform_later(user)}
      .to have_enqueued_job.with(user)
  end
end
