module AuthenticatedTestHelper
  # Sets the current hr in the session from the hr fixtures.
  def login_as(hr)
    @request.session[:hr_id] = hr ? hrs(hr).id : nil
  end

  def authorize_as(hr)
    @request.env["HTTP_AUTHORIZATION"] = hr ? ActionController::HttpAuthentication::Basic.encode_credentials(hrs(hr).login, 'monkey') : nil
  end
  
  # rspec
  def mock_hr
    hr = mock_model(Hr, :id => 1,
      :login  => 'user_name',
      :name   => 'U. Surname',
      :to_xml => "Hr-in-XML", :to_json => "Hr-in-JSON", 
      :errors => [])
    hr
  end  
end
