require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  it 'is valid with a user, project, and message' do
    note = Note.new(
      message: 'This is a shimple note.',
      user: user,
      project: project
    )
    expect(note).to be_valid
  end

  it 'is invalid without a message' do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe 'search message for a term' do
    let(:note1) { FactoryBot.create(:note, project: project, user: user, message: 'This is the first note') }
    let(:note2) { FactoryBot.create(:note, project: project, user: user, message: 'This is the second note') }
    let(:note3) { FactoryBot.create(:note, project: project, user: user, message: 'First, preheate the oven') }
    context 'when a match is found' do
      it 'returns notes that match the serach term' do
        expect(Note.search('first')).to include(note1, note3)
        expect(Note.search('first')).to_not include(note2)
      end
    end
    context 'when no match is found' do
      it 'returns an empty collection when no results are found' do
        expect(Note.search('message')).to be_empty
      end
    end
  end

  it "delegates name to the user who created it" do
    user = double("user", name: "Fake User")
    note = Note.new
    allow(note).to receive(:user).and_return(user)
    expect(note.user_name).to eq "Fake User"
  end

end
