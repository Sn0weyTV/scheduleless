class NotificationsMailerPreview < ActionMailer::Preview
  def employee_joined_location
    u = User.first
    u2 = User.second
    l = Location.first

    NotificationsMailer.employee_joined_location(u, u2, l)
  end

  def schedule_approved
    u = User.first
    sp = SchedulingPeriod.last

    NotificationsMailer.schedule_approved(u, sp)
  end

  def schedule_published
    u = User.first
    sp = SchedulingPeriod.last

    NotificationsMailer.schedule_published(u, sp)
  end

  def new_time_off_approval
    u = User.first
    to = TimeOffRequest.last

    NotificationsMailer.new_time_off_approval(u, to)
  end
end
