require_relative '../lib/cohort_repository'

RSpec.describe CohortRepository do

    it "tests the all function by returning all info on all cohorts" do
        repo1 = CohortRepository.new
        cohorts = repo1.all
        expect(cohorts.length).to eq 3
        expect(cohorts.first.name).to eq "January"
    end

    it "tests the find function by returning information on the first cohort" do
        repo1 = CohortRepository.new
        record = repo1.find(1)
        expect(record.name).to eq "January"
    end

    it "tests the find by function by returning information on the students contained in cohort 1" do
        repo1 = CohortRepository.new
        cohort = repo1.find_with_students(1)
        expect(cohort.id).to eq "1"
        expect(cohort.students.length).to eq 5
        expect(cohort.students.last.name).to eq "Cass"
    end
end