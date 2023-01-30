require 'album_repository'
require 'album'

def reset_table
    seed_sql = File.read('spec/seeds_music_library.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
    connection.exec(seed_sql)
  end

RSpec.describe AlbumRepository do

    before(:each) do 
        reset_table
    end

    it "returns number of entries in database, plus title and ID of the first entry, with the all method" do
        repo1 = AlbumRepository.new
        albums = repo1.all
        expect(albums.length).to eq 9
        expect(albums.first.title).to eq 'AM'
        expect(albums.first.artist_id).to eq '1'
    end

    it "returns the information of a given entry with the find method" do
        repo1 = AlbumRepository.new
        selection = repo1.find(1)
        expect(selection.artist_id).to eq "1"
        expect(selection.title).to eq "AM"
        expect(selection.release_year).to eq "2014"
    end

    it "creates a new album and then returns its title" do
        repo1 = AlbumRepository.new
        newalbum = Album.new 
        newalbum.title = "Joanne"
        newalbum.release_year = "2016"
        newalbum.artist_id = "3"
        repo1.create(newalbum)
        selection = repo1.find(10)
        expect(selection.title).to eq "Joanne"
        expect(selection.artist_id).to eq "3"
        expect(selection.release_year).to eq "2016"
    end

    it "changes the release year of album Chromatica from 2020 to 2021" do
        repo1 = AlbumRepository.new
        repo1.update("Chromatica", "release_year", "2025")
        selection = repo1.find(7)
        expect(selection.release_year).to eq "2025"
    end

    it "deletes album Favourite Worst Nightmare" do
        repo1 = AlbumRepository.new
        repo1.delete("Favourite Worst Nightmare")
        albums = repo1.all
        expect(albums.length).to eq 8
    end
end