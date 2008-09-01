class InterviewObserver < ActiveRecord::Observer
  
  def after_create(interview)
    InterviewMailer.deliver_invite(interview)
  end
end