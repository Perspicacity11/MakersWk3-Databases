require_relative 'cohorts'
require_relative 'students'
require_relative 'database_connection'

class CohortRepository

    def all
        sql = 'SELECT * FROM cohorts;'
        result_set = DatabaseConnection.exec_params(sql, [])

        cohorts = []

        result_set.each do |record|
            cohort = Cohort.new
            cohort.name = record['name']
            cohort.starting_date = record['starting_date']
            cohorts << cohort
        end
        return cohorts
    end

    def find(id)
        sql = 'SELECT * FROM cohorts WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])
        record = result_set.first
        cohort = Cohort.new
        cohort.name = record['name']
        cohort.starting_date = record['starting_date']
        return cohort
    end

    def find_with_students(id)
        sql = "SELECT cohorts.id, cohorts.name, students.name, students.id AS students_id, students.cohort, students.cohort_id
        FROM cohorts
        JOIN students
        ON cohorts.id = students.cohort_id
        WHERE cohorts.id = $1"

        result = DatabaseConnection.exec_params(sql, [id])

        cohort = Cohort.new
        cohort.id = result.first['id']
        cohort.name = result.first['name']
        # cohort.starting_date = result.first['starting_date']
        # cohort.students = result.first['students']

        result.each do |record|
            student = Student.new
            student.name = record['name']
            student.cohort = record['cohort']
            student.id = record['students_id']
            student.cohort_id = record['cohort_id']

            cohort.students << student
        end
        return cohort
    end
end