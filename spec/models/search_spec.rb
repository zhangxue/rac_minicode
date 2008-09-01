require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Search do
  it "should generate conditions" do
    s = Search.new :name=>'snow',:email=>'test',:country=>'China',:city=>'Beijing', :time_zone=>'Beijing', :years_of_working=>2, :available_with=>2,:keyword=>'ruby'
    ["interviews.years_of_working = ?", "name like ?", "interviews.city like ?", "interviews.country=?", "email like ?", "(interview.profile like ? or interview.working_experiences like ?)"].each do |clause|
      s.send("conditions_clauses").include?(clause).should == true
    end
    [2, "%snow%", "%Beijing%", "China", "%test%", "%ruby%"].each do |option|
      s.send('conditions_options').include?(option).should == true
    end
    # s.to_query_conditions.should == ["interviews.years_of_working = ? AND name like ? AND interviews.city like ? AND interviews.country=? AND (interview.profile like ? or interview.working_experiences like ?) AND email like ?", 2, "%snow%", "%Beijing%", "China", "%ruby%", "%ruby%", "%test%"]
  end
end