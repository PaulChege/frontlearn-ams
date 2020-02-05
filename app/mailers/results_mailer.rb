class ResultsMailer < ApplicationMailer
  def results_email
    @student = params[:student]
    @results = params[:results]
    @assessment = params[:assessment]

    mail(
      to: @student.email, 
      subject: "Exam Results", 
      student: @student,
      results: @results,
      assessment: @assessment 
    )
  end
end
