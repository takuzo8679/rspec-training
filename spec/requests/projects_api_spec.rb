require 'rails_helper'

RSpec.describe "Projects Api", type: :request do
  it "loads a project" do
    user = FactoryBot.create(:user)
    FactoryBot.create(:project, name: "Sample project")
    FactoryBot.create(:project, name: "Second sample project", owner: user)

    get api_projects_path, params: { user_email: user.email, user_token: user.authentication_token }
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.length).to eq 1
    
    project_id = json[0]['id']
    get api_project_path(project_id), params: {
    user_email: user.email, user_token: user.authentication_token }
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json['name']).to eq 'Second sample project'
  end

  it 'create a project' do
    user = FactoryBot.create(:user)
    project_param = FactoryBot.attributes_for(:project)
    expect {
      post api_projects_path, params: {
        user_email: user.email, user_token: user.authentication_token,
        project: project_param }
    }.to change(user.projects, :count).by(1)
  end
end
