require 'rails_helper'

RSpec.describe "Projects Api", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user_param = { user_email: @user.email, user_token: @user.authentication_token }
  end

  it "loads a project" do
    FactoryBot.create(:project, name: "Sample project")
    FactoryBot.create(:project, name: "Second sample project", owner: @user)

    get api_projects_path, params: { **@user_param }
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.length).to eq 1
    
    project_id = json[0]['id']
    get api_project_path(project_id), params: { **@user_param }
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json['name']).to eq 'Second sample project'
  end

  it 'create a project' do
    project_param = FactoryBot.attributes_for(:project)
    expect {
      post api_projects_path, params: { **@user_param, project: project_param }
    }.to change(@user.projects, :count).by(1)
  end
end
