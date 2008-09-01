class InterviewsController < ApplicationController
  
  before_filter :check_interview, :only=>[:new, :update]
  
  def new
  end
  
  def update
    @interview.update_attributes!(params[:interview])
    flash[:msg] = 'Thanks, we have received your interview.'
    render :text=>flash[:msg]
  rescue
    render :action=>'new'
  end
  
  private
  
  def check_interview
    @interview = Interview.find_by_candidate_id(params[:candidate_id])
    @candidate = @interview.candidate
    if @interview.finished
      render :text=>"Sorry, you have finished this interview, you can't modify it"
    else
      unless params[:token]==@interview.token
        render :text=>"Sorry, the url you are visiting is invalid, if you click it directly from the email, then try copying the url and pasting it into the browser again"
      end
    end
  end

end
