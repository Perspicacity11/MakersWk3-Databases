require 'posts_repository'
require 'database_connection'


def reset_posts_table
    seed_sql = File.read('spec/socialnetwork_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
  end
  
RSpec.describe PostsRepository do

    before(:each) do 
        reset_posts_table
      end

    it "tests the all function by returning info on all posts" do
        repo1 = PostsRepository.new
        posts = repo1.all
        expect(posts.length).to eq 6
        expect(posts.first.title).to eq "Cass post 1"
    end

    it "tests the find function by returning all info on post 2, Cass post 2" do
        repo1 = PostsRepository.new
        post2 = repo1.find(2)
        expect(post2.title).to eq "Cass post 2"
        expect(post2.contents).to eq "I really hope this works"
        expect(post2.view_count).to eq "5000"
    end

    it "tests the find by user function by returning all posts from user 1, Cass" do
        repo1 = PostsRepository.new
        user1posts = repo1.find_by_user(1)
        expect(user1posts.length).to eq 3
        expect(user1posts.first.title).to eq "Cass post 1"
    end

    it "tests the create function by adding a sixth user and returning their info with find" do
        repo1 = PostsRepository.new
        newpost = Posts.new
        newpost.title = "Luke post 2"
        newpost.contents = "Damn he's been recording for a long time now"
        newpost.view_count = 10000
        repo1.create(newpost)
        lukenewpost = repo1.find(7)
        expect(lukenewpost.title).to eq "Luke post 2"
        expect(lukenewpost.contents).to eq "Damn he's been recording for a long time now"
    end

    it "tests the delete function by removing the fifth post and returning the number fo the remaining posts as five" do
        repo1 = PostsRepository.new
        repo1.delete(5)
        remaining_posts = repo1.all
        expect(remaining_posts.length).to eq 5
        expect(remaining_posts.last.title).to eq "Luke post 1"
    end
end
