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
      @user = User.create(
      first_name: "Aron", 
      last_name: "Summer", 
      email: "tester@example.com", 
      password: "password")
      @user.projects.create(name: "Test Project")
    end
    it "does not allow duplicate project names per user" do
      
      new_project = @user.projects.build(name: "Test Project")
      new_project.valid?
      expect(new_project.errors[:name]).to include("has already been taken")
    end
    it "allows two users to share a project name" do
      other_user = User.create(
      first_name: "Aron2", 
      last_name: "Summer2", 
      email: "tester@example.com2", 
      password: "password2")
      ohter_project = other_user.projects.build(name:"Test Project")
      
      expect(ohter_project).to be_valid
    end
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
end
  