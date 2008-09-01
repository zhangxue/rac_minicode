require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include AuthenticatedTestHelper
describe CandidatesController do
  # fixtures :hrs
  # before(:each) do
  #   login_as :quentin
  # end
  
  it "should parse name_emails" do
    CandidatesController.new.send('parse_name_emails','Snow Zhang<snow@example.com>; Kobe Bryant<kobe@example.com>').size.should == 2
  end
  
  it "should create order" do
    CandidatesController.new.send('order',{:name_order=>'desc'}).should == 'candidates.name desc'
    CandidatesController.new.send('order',{:name_order=>'asc'}).should == 'candidates.name asc'
    CandidatesController.new.send('order',{:interview_time_order=>'desc'}).should == 'interviews.updated_at desc'
    CandidatesController.new.send('order',{:interview_time_order=>'asc'}).should == 'interviews.updated_at asc'
  end

end

describe CandidatesController, "as HR" do
  fixtures :hrs
  before(:each) do
    login_as :quentin
  end
  it "should be able to invite new candidates" do
    get :new
    response.should render_template(:new)
  end
  
  it "should invite multiple candidates when providing valid name_emails" do
    lambda do
      post :create, :name_emails=>"xue zhang< snow@example.com>;\r\nlydia Li< lydia@example.com>"
      flash[:msg].should_not be_nil
      response.should render_template(:new)
    end.should change(Candidate, :count).by(2)      
  end
  
  it "should view all candidates in one view" do
    get :index,:search=>{'name'=>'test','email'=>'test'}
    assigns(:search).should_not be_nil
    response.should render_template(:index)
  end
  
  it "should be able to search candidates" do
    
  end
end
