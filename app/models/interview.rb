class Interview < ActiveRecord::Base
  belongs_to :candidate
  before_create :generate_token
  after_update :update_status
  # after_create :send_interview_invitation
  validates_presence_of :profile,:country,:city, :years_of_working, :available_within,:education, :time_zone, :working_experiences,:on => :update, :message => "can't be blank"
  validates_numericality_of :expected_salary, :on => :update, :message => "can't be blank"
  
  AVAILABILITY = ["immediately",'in a week','in two weeks','in a month','more than a month']
  YEARS = ['None','1-3 years','3-5 years','5-10 years','10 years+']
  
  def finished
    updated_at > created_at
  end
  
  private  
  #
  # A token is generated specifically for certain candidate, so that once candidates have the toaken, (s)he doesn't have to input email and password to fill in interview content.
  # A url containing the token, will be emailed to candidate, when he click the url, he will enter the 'interview' directly
  #  
  def generate_token
    self.token = secure_digest(Time.now, candidate_id)
  end
  
  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
  
  def update_status    
    self.candidate.update_attribute('status', Candidate::INTERVIEW_FINISHED)
  end
  

  # def send_interview_invitation
  #   InterviewMailer.deliver_invite(self)
  # end
  
end
