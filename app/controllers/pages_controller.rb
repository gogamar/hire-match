class PagesController < ApplicationController
  def dashboard
    if @current_candidate
      matched_job_ids = @current_candidate.likes.where(match: true).pluck(:job_id)
      @matched_jobs = Job.where(id: matched_job_ids)
    elsif @current_company
      @jobs = @current_company.jobs
    end

    @quote_of_the_day = FetchQuoteService.new.call
  end
end
