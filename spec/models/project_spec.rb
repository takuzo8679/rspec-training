require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'is invalid without a name' do
    project = Project.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end
  describe 'create project' do
    before do
      # ユーザー作成
      @user = FactoryBot.create(:user)
      @user.projects.create(name: "Test Project")
    end
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }

  end
  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end
    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end
    it "is on time when the due date is on ther futuer" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end
  # callbackテスト
  it "can habe many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
end
  