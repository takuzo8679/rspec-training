require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  # shared_contextの読み込み
  include_context 'project setup'

  describe '#show' do
    it 'responds with json formatted output' do
      sign_in user
      get :show, format: :json,
                 params: { project_id: project.id, id: task.id }
      # expect(response.content_type).to include "application/json"
      expect(response).to have_content_type :json
    end
  end
  describe '#create' do
    it 'responds with json formatted output' do
      sign_in user
      post :create, format: :json,
                    params: { project_id: project.id, task: { name: 'Test task 2' } }
      expect(response).to have_content_type :json
    end
    it 'adds a new task' do
      sign_in user
      expect do
        post :create, format: :json,
                      params: { project_id: project.id, task: { name: 'Test task 2' } }
      end.to change(project.tasks, :count).by(1)
    end
    it 'requires authentification' do
      # sign_in user
      expect do
        post :create, format: :json,
                      params: { project_id: project.id, task: { name: 'Test task 2' } }
      end.to_not change(project.tasks, :count)
      expect(response).to_not be_successful
    end
  end
end
