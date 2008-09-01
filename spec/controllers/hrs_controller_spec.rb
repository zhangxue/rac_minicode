require File.dirname(__FILE__) + '/../spec_helper'
  
# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper


describe HrsController do
  fixtures :hrs

  it 'allows signup' do
    lambda do
      create_hr
      response.should be_redirect
    end.should change(Hr, :count).by(1)
  end

  


  it 'requires login on signup' do
    lambda do
      create_hr(:login => nil)
      assigns[:hr].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Hr, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_hr(:password => nil)
      assigns[:hr].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Hr, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_hr(:password_confirmation => nil)
      assigns[:hr].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Hr, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_hr(:email => nil)
      assigns[:hr].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Hr, :count)
  end
  
  
  
  def create_hr(options = {})
    post :create, :hr => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end
end

describe HrsController do
  describe "route generation" do
    it "should route hrs's 'index' action correctly" do
      route_for(:controller => 'hrs', :action => 'index').should == "/hrs"
    end
    
    it "should route hrs's 'new' action correctly" do
      route_for(:controller => 'hrs', :action => 'new').should == "/signup"
    end
    
    it "should route {:controller => 'hrs', :action => 'create'} correctly" do
      route_for(:controller => 'hrs', :action => 'create').should == "/register"
    end
    
    it "should route hrs's 'show' action correctly" do
      route_for(:controller => 'hrs', :action => 'show', :id => '1').should == "/hrs/1"
    end
    
    it "should route hrs's 'edit' action correctly" do
      route_for(:controller => 'hrs', :action => 'edit', :id => '1').should == "/hrs/1/edit"
    end
    
    it "should route hrs's 'update' action correctly" do
      route_for(:controller => 'hrs', :action => 'update', :id => '1').should == "/hrs/1"
    end
    
    it "should route hrs's 'destroy' action correctly" do
      route_for(:controller => 'hrs', :action => 'destroy', :id => '1').should == "/hrs/1"
    end
  end
  
  describe "route recognition" do
    it "should generate params for hrs's index action from GET /hrs" do
      params_from(:get, '/hrs').should == {:controller => 'hrs', :action => 'index'}
      params_from(:get, '/hrs.xml').should == {:controller => 'hrs', :action => 'index', :format => 'xml'}
      params_from(:get, '/hrs.json').should == {:controller => 'hrs', :action => 'index', :format => 'json'}
    end
    
    it "should generate params for hrs's new action from GET /hrs" do
      params_from(:get, '/hrs/new').should == {:controller => 'hrs', :action => 'new'}
      params_from(:get, '/hrs/new.xml').should == {:controller => 'hrs', :action => 'new', :format => 'xml'}
      params_from(:get, '/hrs/new.json').should == {:controller => 'hrs', :action => 'new', :format => 'json'}
    end
    
    it "should generate params for hrs's create action from POST /hrs" do
      params_from(:post, '/hrs').should == {:controller => 'hrs', :action => 'create'}
      params_from(:post, '/hrs.xml').should == {:controller => 'hrs', :action => 'create', :format => 'xml'}
      params_from(:post, '/hrs.json').should == {:controller => 'hrs', :action => 'create', :format => 'json'}
    end
    
    it "should generate params for hrs's show action from GET /hrs/1" do
      params_from(:get , '/hrs/1').should == {:controller => 'hrs', :action => 'show', :id => '1'}
      params_from(:get , '/hrs/1.xml').should == {:controller => 'hrs', :action => 'show', :id => '1', :format => 'xml'}
      params_from(:get , '/hrs/1.json').should == {:controller => 'hrs', :action => 'show', :id => '1', :format => 'json'}
    end
    
    it "should generate params for hrs's edit action from GET /hrs/1/edit" do
      params_from(:get , '/hrs/1/edit').should == {:controller => 'hrs', :action => 'edit', :id => '1'}
    end
    
    it "should generate params {:controller => 'hrs', :action => update', :id => '1'} from PUT /hrs/1" do
      params_from(:put , '/hrs/1').should == {:controller => 'hrs', :action => 'update', :id => '1'}
      params_from(:put , '/hrs/1.xml').should == {:controller => 'hrs', :action => 'update', :id => '1', :format => 'xml'}
      params_from(:put , '/hrs/1.json').should == {:controller => 'hrs', :action => 'update', :id => '1', :format => 'json'}
    end
    
    it "should generate params for hrs's destroy action from DELETE /hrs/1" do
      params_from(:delete, '/hrs/1').should == {:controller => 'hrs', :action => 'destroy', :id => '1'}
      params_from(:delete, '/hrs/1.xml').should == {:controller => 'hrs', :action => 'destroy', :id => '1', :format => 'xml'}
      params_from(:delete, '/hrs/1.json').should == {:controller => 'hrs', :action => 'destroy', :id => '1', :format => 'json'}
    end
  end
  
  describe "named routing" do
    before(:each) do
      get :new
    end
    
    it "should route hrs_path() to /hrs" do
      hrs_path().should == "/hrs"
      formatted_hrs_path(:format => 'xml').should == "/hrs.xml"
      formatted_hrs_path(:format => 'json').should == "/hrs.json"
    end
    
    it "should route new_hr_path() to /hrs/new" do
      new_hr_path().should == "/hrs/new"
      formatted_new_hr_path(:format => 'xml').should == "/hrs/new.xml"
      formatted_new_hr_path(:format => 'json').should == "/hrs/new.json"
    end
    
    it "should route hr_(:id => '1') to /hrs/1" do
      hr_path(:id => '1').should == "/hrs/1"
      formatted_hr_path(:id => '1', :format => 'xml').should == "/hrs/1.xml"
      formatted_hr_path(:id => '1', :format => 'json').should == "/hrs/1.json"
    end
    
    it "should route edit_hr_path(:id => '1') to /hrs/1/edit" do
      edit_hr_path(:id => '1').should == "/hrs/1/edit"
    end
  end
  
end
