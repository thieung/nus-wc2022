namespace :scheduler do
  # Run every hour at :40
  desc "Check to send list of betters on each match when reaching deadline"
  task send_report_each_match: :environment do
    Game.send_report_to_staffs
  end

  task test_schedule: :environment do
    UserMailer.send_test.deliver
  end
end
