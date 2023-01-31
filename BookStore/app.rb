require_relative 'lib/database_connection'
require_relative 'lib/book_repository'
require_relative 'lib/book'

# We need to give the database name to the method `connect`.
result = DatabaseConnection.connect('book_store')

# Perform a SQL query on the database and get the result set.
# sql = 'SELECT * FROM books;'
# result = DatabaseConnection.exec_params(sql, [])

repo1 = BookRepository.new
result = repo1.all

# Print out each record from the result set
result.each do |book|
  p book.title
end