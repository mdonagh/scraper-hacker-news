This is a demo of how to use Delayed Job.

The Delayed Job gem allows you to schedule jobs into the future and outside of the synchronous response pattern of a web application. All production rails apps use it for something - sending emails, generating reports, etc. It's the easiest to use but least performant of gems in this class - redis/resque, kafka, etc are more heavy-duty but harder to use.

Link.schedule_jobs will schedule one HTTP GET to hacker news for the next 10 minutes - it was meant to be used with Heroku Scheduler to run the rake task 

rake schedule_jobs:now

to run the GET requests once per minute.

Nokogiri used for parsing.

Just look in the Link model for the core of the app.

Also, the database architecture is kind of dumb - should have one table for links, and then check to see if the links already exist, then a second one collecting the page ranks.

Data visualization is relatively easy, I think this is the core of the application and anyone who wants to do this should be able to use this+scaffolding+a simple data visualization library to complete the assignment.

Let me know if you have any questions and thanks for your interest. I think this is a key skill as Rails developers and web scraping like this - using Nokogiri to collect info from a page with CSS selectors - is applicable to a wide array of projects.

Example code

For the period measured, which link stayed on the front page the longest?
```
max_time_distance = 0
longest_lived_link = nil
Link.find_each do |link|
  first_appearance = link.ranks.minimum('created_at')
  last_appearance = link.ranks.maximum('created_at')
  time_distance =  last_appearance.to_i - first_appearance.to_i
  if time_distance > max_time_distance
    max_time_distance = time_distance 
    longest_lived_link = link
  end
end

puts longest_lived_link.inspect

puts "stayed on the page for #{max_time_distance / 60.0} minutes"


Link.find_each do |link|
  first_appearance = link.ranks.minimum('created_at')
  last_appearance = link.ranks.maximum('created_at')
  time_distance =  last_appearance.to_i - first_appearance.to_i
  puts link.url
  puts link.content
  puts "stayed on the page for #{(time_distance / 60.0).round} minutes"
end
```