Factory.define :candidate do |f|
  # f.name_email 'Snow, C. Zhang < snow@example.com>'
  f.name 'Snow Zhang'
  f.email 'snow@example.com'
end
Factory.define :interview do |f|
  f.candidate {|c| c.association(:candidate)}
  f.profile 'test'
  f.country 'China'
  f.city 'Beijing'
  f.time_zone 'Beijing'
  f.working_experiences 'test'
  f.education 'Master'
  f.years_of_working 'none'
  f.expected_salary 1000
  f.available_within 'in a week'
end