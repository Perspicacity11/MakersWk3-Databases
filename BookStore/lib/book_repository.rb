 require_relative 'book'
 
 class BookRepository

    def all
        sql = 'SELECT * FROM books;'
        result_set = DatabaseConnection.exec_params(sql, [])

        books = []

        result_set.each do |record|
            book = Book.new
            book.title = record['title']
            book.author_name = record['author_name']

            books << book
        end
        return books
    end

    def find(id)
        sql = "SELECT * FROM books WHERE id = $1"
        result_set = DatabaseConnection.exec_params(sql, [id])
        record = result_set[0]
        book = Book.new
        book.title = record['title']
        book.author_name = record['author_name']
        return book
    end

    def create(book)
        sql = "INSERT INTO books (title, author_name) VALUES($1, $2);"
        DatabaseConnection.exec_params(sql, [book.title, book.author_name])
     end


    def update(book, column_name, new_value)
        sql = "UPDATE books SET #{column_name} = '#{new_value}';"
        DatabaseConnection.exec_params(sql, [])
    end
       
    def delete(id)
        sql = "DELETE FROM books WHERE id = $1"
        DatabaseConnection.exec_params(sql, [id])
    end

end