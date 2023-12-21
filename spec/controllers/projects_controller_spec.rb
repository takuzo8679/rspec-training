require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "#index" do
    context "#as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user # 認証することで302リダイレクトにならない
      end
      it "responds successfully" do
        get "index"
        expect(response).to be_successful
      end
      it "returns a 200 response" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
    context "as a gesut" do
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "#show" do
    context "as an authorized user" do
      before do
        user = FactoryBot.create(:user)
        sign_in user
        @project = FactoryBot.create(:project, owner: user)
      end
      it "response successfully" do
        get :show, params: { id: @project.id }
        expect(response).to be_successful
      end
    end
    context "as an unauthorized user" do
      before do
        user = FactoryBot.create(:user)
        sign_in user
        other_user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: other_user)
      end
      it "redirect to the dashboard" do
        get :show, params: { id: @project.id }
        expect(response).to redirect_to root_path
      end
    end
  end
  describe "#create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end
      it "adds a project" do
        project_params = FactoryBot.attributes_for(:project)
        # blockで渡す必要がる
        expect {
        post :create, params: { project: project_params }
      }.to change(@user.projects, :count).by(1)
      end
    end
    context "as a guest" do
      before do
        project_params = FactoryBot.attributes_for(:project)
        post :create, params: {project: project_params}
      end
      it "returns a 302 response" do
        expect(response).to have_http_status(302)
      end
      it "redirects to the sign-in page" do
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
