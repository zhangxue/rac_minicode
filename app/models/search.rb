class Search 
  attr_accessor :name,:email,:country,:city,:years_of_working,:keyword,:available_within,:finished
  alias attributes instance_values
  
  def initialize(attrs=nil)
    if attrs
      self.name = attrs[:name]
      self.email = attrs[:email]
      self.country = attrs[:country]
      self.city = attrs[:city]
      self.years_of_working = attrs[:years_of_working]
      self.keyword = attrs[:keyword]
      self.available_within = attrs[:available_within]
      self.finished = attrs[:finished] && attrs[:finished].to_i==1 
    end
  end
  
  def to_query_conditions
    conditions
  end
  
  private
  def name_conditions
    ['name like ?', "%#{name}%"] unless name.blank?
  end
  
  def email_conditions
    ['email like ?', "%#{email}%"] unless email.blank?
  end
  
  def country_conditions
    ['interviews.country=?',country] unless country.blank?
  end
  
  def city_conditions
    ['interviews.city like ?', "%#{city}%"] unless city.blank?
  end
  
  def available_within_conditions
    ['interviews.available_within = ?',available_within] unless available_within.blank?
  end
  
  def years_of_working_conditions
    ['interviews.years_of_working = ?', years_of_working] unless years_of_working.blank?
  end
  
  def keyword_conditions
    ['(interview.profile like ? or interview.working_experiences like ?)', "%#{keyword}%","%#{keyword}%"] unless keyword.blank?
  end
  
  def finished_conditions
    ['interviews.created_at<>interviews.updated_at',finished] if finished==true
  end
  
  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end

end