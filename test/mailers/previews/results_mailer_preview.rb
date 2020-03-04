# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/result_mailer
class ResultsMailerPreview < ActionMailer::Preview
  def results_email
    result = Result.where.not(final_assessment: nil).first
    ResultsMailer.with(
      student: result.student,
      results: [result],
      assessment: result.assessment
    ).results_email
  end
end
