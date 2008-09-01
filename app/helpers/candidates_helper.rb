module CandidatesHelper
  
  def name_order_params
    options = params.clone
    options.delete(:interview_time_order)
    options.merge(:name_order=>(options[:name_order] ? (options[:name_order]=='asc' ? 'desc' : 'asc') : 'asc'))
  end
  
  def interview_time_order_params
    options = params.clone
    options.delete(:name_order)
    options.merge(:interview_time_order=>(options[:interview_time_order] ? (options[:interview_time_order]=='asc' ? 'desc' : 'asc') : 'asc'))
  end
end
