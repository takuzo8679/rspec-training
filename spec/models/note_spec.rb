require 'rails_helper'

RSpec.describe Note, type: :model do
  
  it 'returns notes that match the serach term' do
    user = User.create(
      first_name: "Aron", 
      last_name: "Summer", 
      email: "tester@example.com", 
      password: "password")
    project = user.projects.create(name: "Test Project")
    
    note1 = project.notes.create(message: 'This is the first note', user: user)
    note2 = project.notes.create(message: 'This is the second note', user: user)
    note3 = project.notes.create(message: 'First, preheate the oven', user: user)

    expect(Note.search('first')).to include(note1, note3)
    expect(Note.search('first')).to_not include(note2)
  end

  it 'returns an empty collection when no results are found' do
    user = User.create(
      first_name: "Aron", 
      last_name: "Summer", 
      email: "tester@example.com", 
      password: "password")
    project = user.projects.create(name: "Test Project")
    
    note1 = project.notes.create(message: 'This is the first note', user: user)
    note2 = project.notes.create(message: 'This is the second note', user: user)
    note3 = project.notes.create(message: 'First, preheate the oven', user: user)

    expect(Note.search('message')).to be_empty
  end
end
