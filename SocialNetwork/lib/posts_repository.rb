require_relative './posts'
require_relative './users'
require_relative './users_repository'

class PostsRepository

    def all
        sql = 'SELECT * FROM posts;'
        result_set = DatabaseConnection.exec_params(sql, [])

        posts = []

        result_set.each do |record|
            post = Posts.new
            post.title = record['title']
            post.contents = record['contents']
            post.view_count = record['view_count']
            posts << post
        end
        return posts
    end

    def find(id)
        sql = 'SELECT * FROM posts WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])
        record = result_set.first
        post = Posts.new
        post.title = record['title']
        post.contents = record['contents']
        post.view_count = record['view_count']
        return post
    end

    def find_by_user(user_id)
        sql = 'SELECT * FROM posts WHERE user_id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [user_id])
        posts = []

        result_set.each do |record|
            post = Posts.new
            post.title = record['title']
            post.contents = record['contents']
            post.view_count = record['view_count']
            posts << post
        end
        return posts
    end

    def create(post)
        sql = "INSERT INTO posts (title, contents, view_count) VALUES($1, $2, $3);"
        DatabaseConnection.exec_params(sql, [post.title, post.contents, post.view_count])
    end

    def delete(id)
        sql = "DELETE FROM posts WHERE id = $1;"
        DatabaseConnection.exec_params(sql, [id])
    end

end