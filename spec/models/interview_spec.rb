require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Interview do
  before(:each) do
    # @interview = Interview.new
    @emails = ActionMailer::Base.deliveries
    @emails.clear
    # @candidate = Factory.create(:candidate)
  end
  
  it 'should create interview' do
    interview = Factory.create(:interview)
    interview.candidate_id.should_not be_nil
    interview.token.should_not be_nil
    @emails.size.should == 2 # two interview object are created
  end
  
  describe 'when candidate save the interview' do
    it "should validate presence of profile, country, city, time_zone, education, working_experiences " do
      %w(profile country city time_zone education working_experiences years_of_working available_within).each do |e|
        i = Factory.create(:interview)
        i.send(e+"=",'')
        i.save
        i.should have(1).error_on(e)
      end
    end
  
    it 'should validate numericality of years_of_working and expected_salary' do
      %w(expected_salary).each do |e|
        i = Factory.create(:interview)
        i.send(e+'=',1)
        i.save
        i.should have(0).error_on(e)
        i.send(e+'=','a')
        i.save
        i.should have(1).error_on(e)
      end
    end
    
    it "should save interview after filling all fields" do
      i = Factory.create(:interview)
      attributes = i.attributes
      attributes.delete('candidate_id')
      attributes.delete('token')
      l = lambda{        
        c = Factory.create(:candidate)
        c.interview.update_attributes(attributes)
        Candidate.find(c.id).status.should == Candidate::INTERVIEW_FINISHED
      }
      l.should change(Interview, :count).by(1)      
    end
  end

end
