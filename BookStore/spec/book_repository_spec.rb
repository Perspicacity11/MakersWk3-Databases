 require 'book_repository'
 require 'book'

 def reset_table
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store' })
    connection.exec(seed_sql)
  end

 RSpec.describe BookRepository do

    before(:each) do 
        reset_table
    end

it "reads back the full database, using the all method" do
    repo1 = BookRepository.new
    books = repo1.all
    expect(books.length).to eq 5
    expect(books.first.title).to eq "Nineteen Eighty-Four"
end

it "reads back a specific entry, testing the find method" do
    repo1 = BookRepository.new
    selection = repo1.find(2)
    expect(selection.title).to eq "Mrs Dalloway"
    expect(selection.author_name).to eq "Virginia Woolf"
end

it "creates a new book and then returns its title" do
    repo1 = BookRepository.new
    newbook = Book.new 
    newbook.title = "Fahrenheit 451"
    newbook.author_name = "Ray Bradbury"
    repo1.create(newbook)
    selection = repo1.find(5)
    expect(selection.title).to eq "Fahrenheit 451"
    expect(selection.author_name).to eq "Ray Bradbury"
end

it "changes the author name of book Emma to Watson" do
    repo1 = BookRepository.new
    repo1.update("Emma", "title", "Watson")
    selection = repo1.find(3)
    expect(selection.title).to eq "Watson"
end

it "deletes book Dracula" do
    repo1 = BookRepository.new
    repo1.delete("Dracula")
    albums = repo1.all
    expect(albums.length).to eq 4
end
    
end