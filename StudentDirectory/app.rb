require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'

result = DatabaseConnection.connect('student_directory_1')

puts "Enter a cohort number to list its students: "
input = gets.chomp

repo1 = CohortRepository.new
record = repo1.find_with_students(input)

record.students.each do |student|
    puts "Student ID: #{student.id} - #{student.name}, #{student.cohort}"
end

