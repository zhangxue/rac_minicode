class CandidatesController < ApplicationController
  
  before_filter :login_required, :only=>[:index,:new]
  layout 'backoffice'
  def new
    # render :layout=>'backoffice'
  end
  
  def create
    @name_emails = params[:name_emails]
    formatted_name_emails = parse_name_emails(@name_emails)
    if formatted_name_emails      
      formatted_name_emails.each do |ne|
        Candidate.create!(:name_email=>ne)
      end
      flash[:msg] = "Invites have been sent to candidates"
    else
      flash[:error] = 'Please specify one or more candidates'      
    end
  rescue
    flash[:error] = "Invalid format of candidate, please double check"
  ensure
    render :action=>'new'
  end
  
  def index
    @search = Search.new(params[:search])
    @candidates = Candidate.paginate(:per_page=>5,:page=>params[:page],:order=>order,:conditions=>@search.to_query_conditions,:include=>[:interview])
  end
  
  private
  
  def order(orders=params)    
    return "candidates.name #{orders[:name_order]}" if orders[:name_order]    
    return "interviews.updated_at #{orders[:interview_time_order]}" if orders[:interview_time_order]
    return 'interviews.updated_at desc' if !(orders[:name_order] || orders[:interview_time_order])
  end
  
  def parse_name_emails(name_emails='')
    name_emails.split(';').collect(&:strip) if name_emails && !name_emails.empty?
  end
end
