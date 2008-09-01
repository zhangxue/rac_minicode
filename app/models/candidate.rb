class Candidate < ActiveRecord::Base
  has_one :interview
  NAME_EMAIL_PATTERN = /([\S\s]+)<\s*(\S+@\S+)\s*>/
  attr_accessor :name_email
  before_validation :parse_name_email
  after_create :create_interview
  validates_presence_of :email
  
  INTERVIEW_FINISHED = 1
  
  private
  def parse_name_email
    if self.name_email && self.name_email=~NAME_EMAIL_PATTERN
      self.name = $1.strip
      self.email = $2.strip
    end
  end
  
  def create_interview
    Interview.create(:candidate=>self)
  end
  
end
