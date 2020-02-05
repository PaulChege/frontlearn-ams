# Preview all emails at http://localhost:3000/rails/mailers/result_mailer
class ResultsMailerPreview < ActionMailer::Preview
  def results_email
    student = Student.new(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@gmail.com",
      mobile_number: "0711222333"
    )
    ResultsMailer.with(student: student, results: []).results_email
  end
end
