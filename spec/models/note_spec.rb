require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'search message for a term' do
    context 'when a match is found' do
      it 'returns notes that match the serach term' do
        user = User.create(
        first_name: 'Aron',
        last_name: 'Summer',
        email: 'tester@example.com',
        password: 'password'
        )
        project = user.projects.create(name: 'Test Project')
        
        note1 = project.notes.create(message: 'This is the first note', user:)
        note2 = project.notes.create(message: 'This is the second note', user:)
        note3 = project.notes.create(message: 'First, preheate the oven', user:)
        
        expect(Note.search('first')).to include(note1, note3)
        expect(Note.search('first')).to_not include(note2)
      end
    end
    context 'when no match is found' do
      
      it 'returns an empty collection when no results are found' do
        user = User.create(
        first_name: 'Aron',
        last_name: 'Summer',
        email: 'tester@example.com',
        password: 'password'
        )
        project = user.projects.create(name: 'Test Project')
        
        note1 = project.notes.create(message: 'This is the first note', user:)
        note2 = project.notes.create(message: 'This is the second note', user:)
        note3 = project.notes.create(message: 'First, preheate the oven', user:)
        
        expect(Note.search('message')).to be_empty
      end
    end
  end
end
