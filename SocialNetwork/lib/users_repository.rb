require_relative './users'

class UsersRepository

    def all
        sql = 'SELECT * FROM users;'
        result_set = DatabaseConnection.exec_params(sql, [])

        users = []

        result_set.each do |record|
            user = Users.new
            user.username = record['username']
            user.email_address = record['email_address']
            users << user
        end
        return users
    end

    def find(id)
        sql = 'SELECT * FROM users WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])
        record = result_set.first
        user = Users.new
        user.username = record['username']
        user.email_address = record['email_address']
        return user
    end

    def create(user)
        sql = "INSERT INTO users (username, email_address) VALUES($1, $2);"
        DatabaseConnection.exec_params(sql, [user.username, user.email_address])
    end

    def delete(id)
        sql = "DELETE FROM users WHERE id = $1;"
        DatabaseConnection.exec_params(sql, [id])
    end

end