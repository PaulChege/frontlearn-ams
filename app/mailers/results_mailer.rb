# frozen_string_literal: true

class ResultsMailer < ApplicationMailer
  def results_email
    @student = params[:student]
    @results = params[:results]
    @assessment = params[:assessment]

    mail(
      to: @student.email,
      subject: 'Assessment Results',
      student: @student,
      results: @results,
      assessment: @assessment
    )
  end
end
