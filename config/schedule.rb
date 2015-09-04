# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 1.day, at: '2:30 pm' do
  runner "Sms.send_debt_messages"
end

every 5.minutes do
  runner "RrdcronTasks.datacreator"
end

every "2 * * * *" do
  runner "ChangesTasks.new.send_changes"
end

every 3.hours do
  runner "InetMembersTasks.datageneration"
end

every 1.hours do
  runner "MikrotikMembersTasks.datagenerate"
end

every 1.day, at: '10:00 pm' do
  runner "BalanceNotificationsTasks.notification_new"
end


every 1.day, at: '11:00 pm' do
  runner "YealinksTasks.mobiledata"
end

every 1.day, at: '21:00 pm' do
  runner "UsersFullyDataTasks.data_by_node"
end

# Learn more: http://github.com/javan/whenever
