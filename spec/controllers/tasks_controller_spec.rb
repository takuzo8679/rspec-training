require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, owner: @user)
    @task = @project.tasks.create!(name: "Test task")
  end
  describe "#show" do
    it "responds with json formatted output" do
      sign_in @user
      get :show, format: :json,
        params: {project_id: @project.id, id: @task.id }
      expect(response.content_type).to include "application/json"
    end
  end
  describe "#create" do
    it "responds with json formatted output" do
      sign_in @user
      post :create, format: :json,
        params: {project_id: @project.id, task: {name: "Test task 2"} }
      expect(response.content_type).to include "application/json"
    end
    it "adds a new task" do
      sign_in @user
      expect { post :create, format: :json,
        params: {project_id: @project.id, task: {name: "Test task 2"}}
      }.to change(@project.tasks, :count).by(1)
    end
    it "requires authentification" do
      # sign_in @user
      expect { post :create, format: :json,
        params: {project_id: @project.id, task: {name: "Test task 2"}}
      }.to_not change(@project.tasks, :count)
      expect(response).to_not be_successful
    end
  end
end
