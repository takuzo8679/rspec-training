require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # it "is valid with a first name, last name, email, and password" do
  #   user = User.new(
  #   first_name: "Aron",
  #   last_name: "Summer",
  #   email: "tester@example.com",
  #   password: "password")
  #   expect(user).to be_valid
  # end

  # it "is invalid without a first name" do
  #   user = FactoryBot.build(:user, first_name: nil)
  #   user.valid?
  #   expect(user.errors[:first_name]).to include("can't be blank")
  # end
  # it "is invalid without a last name" do
  #   user = FactoryBot.build(:user, last_name: nil)
  #   user.valid?
  #   expect(user.errors[:last_name]).to include("can't be blank")
  # end
  # it "is invalid without a email address" do
  #   user = FactoryBot.build(:user, email: nil)
  #   user.valid?
  #   expect(user.errors[:email]).to include("can't be blank")
  # end
  # it "is invalid with a duplicate email address" do
  #   FactoryBot.create(:user, email: 'tester@expample.com')
  #   user = FactoryBot.build(:user, email: 'tester@expample.com')
  #   user.valid?
  #   expect(user.errors[:email]).to include("has already been taken")
  # end
  it { is_expected.to validate_presence_of :first_name}
  it { is_expected.to validate_presence_of :last_name}
  it { is_expected.to validate_presence_of :email}
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  # it "returns a user's full name as a string" do
  #   user = FactoryBot.build(:user, first_name: "Aran", last_name: "Last")
  #   expect(user.name).to eq "Aran Last"
  # end
  subject(:user) { FactoryBot.build(:user, first_name: "Aran", last_name: "Last")}
  it { is_expected.to satisfy { |user| user.name == "Aran Last" } }
end
