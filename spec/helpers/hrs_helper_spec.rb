require File.dirname(__FILE__) + '/../spec_helper'
include ApplicationHelper
include HrsHelper
include AuthenticatedTestHelper

describe HrsHelper do
  before do
    @hr = mock_hr
  end
  
  describe "if_authorized" do 
    it "yields if authorized" do
      should_receive(:authorized?).with('a','r').and_return(true)
      if_authorized?('a','r'){|action,resource| [action,resource,'hi'] }.should == ['a','r','hi']
    end
    it "does nothing if not authorized" do
      should_receive(:authorized?).with('a','r').and_return(false)
      if_authorized?('a','r'){ 'hi' }.should be_nil
    end
  end
  
  describe "link_to_hr" do
    it "should give an error on a nil hr" do
      lambda { link_to_hr(nil) }.should raise_error('Invalid hr')
    end
    it "should link to the given hr" do
      should_receive(:hr_path).at_least(:once).and_return('/hrs/1')
      link_to_hr(@hr).should have_tag("a[href='/hrs/1']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_hr(@hr, :content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_hr(@hr).should have_tag("a", 'user_name')
    end
    it "should use the name as link text with :content_method => :name" do
      link_to_hr(@hr, :content_method => :name).should have_tag("a", 'U. Surname')
    end
    it "should use the login as title with no :title_method specified" do
      link_to_hr(@hr).should have_tag("a[title='user_name']")
    end
    it "should use the name as link title with :content_method => :name" do
      link_to_hr(@hr, :title_method => :name).should have_tag("a[title='U. Surname']")
    end
    it "should have nickname as a class by default" do
      link_to_hr(@hr).should have_tag("a.nickname")
    end
    it "should take other classes and no longer have the nickname class" do
      result = link_to_hr(@hr, :class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

  describe "link_to_login_with_IP" do
    it "should link to the login_path" do
      link_to_login_with_IP().should have_tag("a[href='/login']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_login_with_IP('Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_login_with_IP().should have_tag("a", '0.0.0.0')
    end
    it "should use the ip address as title" do
      link_to_login_with_IP().should have_tag("a[title='0.0.0.0']")
    end
    it "should by default be like school in summer and have no class" do
      link_to_login_with_IP().should_not have_tag("a.nickname")
    end
    it "should have some class if you tell it to" do
      result = link_to_login_with_IP(nil, :class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
    it "should have some class if you tell it to" do
      result = link_to_login_with_IP(nil, :tag => 'abbr')
      result.should have_tag("abbr[title='0.0.0.0']")
    end
  end

  describe "link_to_current_hr, When logged in" do
    before do
      stub!(:current_hr).and_return(@hr)
    end
    it "should link to the given hr" do
      should_receive(:hr_path).at_least(:once).and_return('/hrs/1')
      link_to_current_hr().should have_tag("a[href='/hrs/1']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_current_hr(:content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_current_hr().should have_tag("a", 'user_name')
    end
    it "should use the name as link text with :content_method => :name" do
      link_to_current_hr(:content_method => :name).should have_tag("a", 'U. Surname')
    end
    it "should use the login as title with no :title_method specified" do
      link_to_current_hr().should have_tag("a[title='user_name']")
    end
    it "should use the name as link title with :content_method => :name" do
      link_to_current_hr(:title_method => :name).should have_tag("a[title='U. Surname']")
    end
    it "should have nickname as a class" do
      link_to_current_hr().should have_tag("a.nickname")
    end
    it "should take other classes and no longer have the nickname class" do
      result = link_to_current_hr(:class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

  describe "link_to_current_hr, When logged out" do
    before do
      stub!(:current_hr).and_return(nil)
    end
    it "should link to the login_path" do
      link_to_current_hr().should have_tag("a[href='/login']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_current_hr(:content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use 'not signed in' as link text with no :content_method specified" do
      link_to_current_hr().should have_tag("a", 'not signed in')
    end
    it "should use the ip address as title" do
      link_to_current_hr().should have_tag("a[title='0.0.0.0']")
    end
    it "should by default be like school in summer and have no class" do
      link_to_current_hr().should_not have_tag("a.nickname")
    end
    it "should have some class if you tell it to" do
      result = link_to_current_hr(:class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

end
