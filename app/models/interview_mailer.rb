class InterviewMailer < ActionMailer::Base
  

  def invite(interview)
    subject    'Online Interview'
    recipients interview.candidate.email
    from       'jobs@richapplicationsconsulting.com'
    sent_on    Time.now
    @body['name'] = interview.candidate.name
    @body['url'] = new_candidate_interview_url(:candidate_id=>interview.candidate.id,:token=>interview.token,:host=>'localhost:3000')
  end

end
