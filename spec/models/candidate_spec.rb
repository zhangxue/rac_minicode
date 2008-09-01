require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Candidate do
  # before(:each) do
  #   @candidate = Candidate.new
  # end

  it "should create valid candidate" do
    ['Snow,C. Zhang<snow@example.com>', 'Snow,C. Zhang < snow@example.com>'].each do |e|
      p = lambda{
        c = Factory.create(:candidate,:name_email=>e)
        c.name.should == 'Snow,C. Zhang'
        c.email.should == 'snow@example.com'
      }
      p.should change(Candidate, :count).by(1)
    end
  end
  
  it 'should validate email presence' do    
    Factory.build(:candidate,:name_email=>'Snow,C. Zhang',:email=>'',:name=>'').should have(1).error_on(:email)
  end
end
