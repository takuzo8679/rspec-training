require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "Aron", 
      last_name: "Summer", 
      email: "tester@example.com", 
      password: "password")
    user.projects.create(name: "Test Project")
    new_project = user.projects.build(name: "Test Project")
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end
  it "allows two users to share a project name" do
    user = User.create(
      first_name: "Aron", 
      last_name: "Summer", 
      email: "tester@example.com", 
      password: "password")
    user.projects.create(name: "Test Project")
    other_user = User.create(
      first_name: "Aron2", 
      last_name: "Summer2", 
      email: "tester@example.com2", 
      password: "password2")
    ohter_project = other_user.projects.build(name:"Test Project")
    
    expect(ohter_project).to be_valid
  end
end
