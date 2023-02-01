require 'users_repository'
require 'database_connection'


def reset_users_table
    seed_sql = File.read('spec/socialnetwork_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
  end
  
RSpec.describe UsersRepository do

    before(:each) do 
        reset_users_table
      end

    it "tests the all function by returning all info on all users" do
        repo1 = UsersRepository.new
        users = repo1.all
        expect(users.length).to eq 5
        expect(users.first.username).to eq "Cass Naylor"
    end

    it "tests the find function by returning all info on user 2, Ed" do
        repo1 = UsersRepository.new
        user2 = repo1.find(2)
        expect(user2.username).to eq "Ed Thomas"
        expect(user2.email_address).to eq "edward@makers.com"
    end

    it "tests the find function by returning all info on user 1, Cass" do
        repo1 = UsersRepository.new
        user1 = repo1.find(1)
        expect(user1.username).to eq "Cass Naylor"
        expect(user1.email_address).to eq "cassius@makers.com"
    end

    it "tests the create function by adding a sixth user and returning their info with find" do
        repo1 = UsersRepository.new
        newuser = Users.new
        newuser.username = "Anna Magnusson"
        newuser.email_address = "anna@makers.com"
        repo1.create(newuser)
        anna = repo1.find(6)
        expect(anna.username).to eq "Anna Magnusson"
        expect(anna.email_address).to eq "anna@makers.com"
    end

    it "tests the delete function by removing the fifth user and returning the number fo the remaining users as four" do
        repo1 = UsersRepository.new
        repo1.delete(5)
        remaining_users = repo1.all
        expect(remaining_users.length).to eq 4
        expect(remaining_users.last.username).to eq "Ryan Lai"
    end
end
