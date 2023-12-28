require 'rails_helper'

RSpec.describe 'Notes', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:project) { FactoryBot.create(:project, owner: user, name: 'RSpec tutorial') }

  scenario 'user upload an attachment' do
    sign_in user
    visit project_path(project)
    click_link 'Add Note'
    fill_in 'Message', with: 'My book cover'
    attach_file 'Attachment', "#{Rails.root}/spec/files/attachment.png"
    click_button 'Create Note'

    expect(page).to have_content 'Note was successfully created'
    expect(page).to have_content 'My book cover'
    expect(page).to have_content 'attachment.png (image/png'
  end
end
