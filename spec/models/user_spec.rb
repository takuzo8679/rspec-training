require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with a first name, last name, email, and password" do
    user = User.new(
    first_name: "Aron", 
    last_name: "Summer", 
    email: "tester@example.com", 
    password: "password")
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end
  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
  it "is invalid without a email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it "is invalid with a duplicate email address" do
    User.create(
      first_name: "Aron", 
      last_name: "Summer", 
      email: "tester@example.com", 
      password: "password")
    user = User.new(
      first_name: "Aron", 
      last_name: "Summer", 
      email: "tester@example.com", 
      password: "password")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  it "returns a user's full name as a string" do
    user = User.create(
    first_name: "Aran",
    last_name: "Last",
    email: "test@example.com",
    password: "password"
    )
    expect(user.name).to eq "Aran Last"
  end
end
