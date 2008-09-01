require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InterviewsController, 'as candidate' do
  before(:each) do
    @candidate = Factory.create(:candidate)
  end
  
  it "should be lead to online interview form when clicks the url in invite email" do
    get 'new', :candidate_id=>@candidate.id, :token=>@candidate.interview.token
    assigns(:interview).should_not be_nil
    assigns(:candidate).should_not be_nil
    response.should be_success
  end

  it "form should be submitted" do
    put 'update', :interview=>sample_interview, :candidate_id=>@candidate.id, :token=>@candidate.interview.token
    flash[:msg].should_not be_nil
    response.should be_success
  end

  it "form should not be submitted if required fields are not filled" do
    put 'update',:candidate_id=>@candidate.id, :token=>@candidate.interview.token,:interview=>{}
    assigns(:interview).errors.size.should > 0
    response.should render_template('new')      
  end
end
  
  
  def sample_interview(options={})
    {
      :education=>'Master',
      :years_of_working=>"none",
      :profile=>'test',
      :working_experiences=>'test',
      :country=>'China',
      :city=>'Beijing',
      :time_zone=>'Beijing',
      :expected_salary=>'1000',
      :available_within=>"in a week"
      }.merge options
  end

