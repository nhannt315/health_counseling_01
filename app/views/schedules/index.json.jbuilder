json.isDoctor current_user.is_a?(Doctor)
json.schedules @doctor.schedules do |schedule|
  json.id schedule.id
  json.title schedule.title
  json.start schedule.start_time
  json.end schedule.stop_time
  json.isAllDay false
  json.category schedule.category.name
  json.location schedule.location
  json.description schedule.reason
  json.state schedule.state
  json.type schedule.schedule_type
  json.user_editable schedule.user.current_user?(current_user)
  json.doctor_editable schedule.doctor.current_user?(current_user)
  json.accepted schedule.accept
end
