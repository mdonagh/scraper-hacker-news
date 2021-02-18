namespace :schedule_jobs do
  desc "This task does nothing"
  task :now do
    for i in 1..10
      Link.delay(run_at: i.minutes.from_now).get_ranks
    end
  end
end
