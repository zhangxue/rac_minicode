require File.dirname(__FILE__) + '/../helper'

RE_Hr      = %r{(?:(?:the )? *(\w+) *)}
RE_Hr_TYPE = %r{(?: *(\w+)? *)}
steps_for(:hr) do

  #
  # Setting
  #
  
  Given "an anonymous hr" do 
    log_out!
  end

  Given "$an $hr_type hr with $attributes" do |_, hr_type, attributes|
    create_hr! hr_type, attributes.to_hash_from_story
  end
  
  Given "$an $hr_type hr named '$login'" do |_, hr_type, login|
    create_hr! hr_type, named_hr(login)
  end
  
  Given "$an $hr_type hr logged in as '$login'" do |_, hr_type, login|
    create_hr! hr_type, named_hr(login)
    log_in_hr!
  end
  
  Given "$actor is logged in" do |_, login|
    log_in_hr! @hr_params || named_hr(login)
  end
  
  Given "there is no $hr_type hr named '$login'" do |_, login|
    @hr = Hr.find_by_login(login)
    @hr.destroy! if @hr
    @hr.should be_nil
  end
  
  #
  # Actions
  #
  When "$actor logs out" do 
    log_out
  end

  When "$actor registers an account as the preloaded '$login'" do |_, login|
    hr = named_hr(login)
    hr['password_confirmation'] = hr['password']
    create_hr hr
  end

  When "$actor registers an account with $attributes" do |_, attributes|
    create_hr attributes.to_hash_from_story
  end
  

  When "$actor logs in with $attributes" do |_, attributes|
    log_in_hr attributes.to_hash_from_story
  end
  
  #
  # Result
  #
  Then "$actor should be invited to sign in" do |_|
    response.should render_template('/sessions/new')
  end
  
  Then "$actor should not be logged in" do |_|
    controller.logged_in?.should_not be_true
  end
    
  Then "$login should be logged in" do |login|
    controller.logged_in?.should be_true
    controller.current_hr.should === @hr
    controller.current_hr.login.should == login
  end
    
end

def named_hr login
  hr_params = {
    'admin'   => {'id' => 1, 'login' => 'addie', 'password' => '1234addie', 'email' => 'admin@example.com',       },
    'oona'    => {          'login' => 'oona',   'password' => '1234oona',  'email' => 'unactivated@example.com'},
    'reggie'  => {          'login' => 'reggie', 'password' => 'monkey',    'email' => 'registered@example.com' },
    }
  hr_params[login.downcase]
end

#
# Hr account actions.
#
# The ! methods are 'just get the job done'.  It's true, they do some testing of
# their own -- thus un-DRY'ing tests that do and should live in the hr account
# stories -- but the repetition is ultimately important so that a faulty test setup
# fails early.  
#

def log_out 
  get '/sessions/destroy'
end

def log_out!
  log_out
  response.should redirect_to('/')
  follow_redirect!
end

def create_hr(hr_params={})
  @hr_params       ||= hr_params
  post "/hrs", :hr => hr_params
  @hr = Hr.find_by_login(hr_params['login'])
end

def create_hr!(hr_type, hr_params)
  hr_params['password_confirmation'] ||= hr_params['password'] ||= hr_params['password']
  create_hr hr_params
  response.should redirect_to('/')
  follow_redirect!

end



def log_in_hr hr_params=nil
  @hr_params ||= hr_params
  hr_params  ||= @hr_params
  post "/session", hr_params
  @hr = Hr.find_by_login(hr_params['login'])
  controller.current_hr
end

def log_in_hr! *args
  log_in_hr *args
  response.should redirect_to('/')
  follow_redirect!
  response.should have_flash("notice", /Logged in successfully/)
end
