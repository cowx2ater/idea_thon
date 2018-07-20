desc "Send appointment reminders"
task :update_crawl => :environment do # :environment will load our Rails app, so we can query the database with ActiveRecord
  Team.update_vote
end
