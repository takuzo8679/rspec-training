require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  context 'as an authenticated user' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    context 'with valid attributes' do
      it 'adds a project' do
        project_params = FactoryBot.attributes_for(:project)
        expect do
          post projects_path, params: { project: project_params }
        end.to change(@user.projects, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      it 'does not add a project' do
        project_params = FactoryBot.attributes_for(:project, name: nil)
        expect do
          post projects_path, params: { project: project_params }
        end.to_not change(@user.projects, :count)
      end
    end
  end
end
