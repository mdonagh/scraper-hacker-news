class Link < ApplicationRecord


  def self.schedule_jobs
    for i in 1..10
    Link.delay(run_at: i.minutes.from_now).get_ranks
    end
  end

  def self.get_ranks
    response = HTTParty.get('https://news.ycombinator.com/')
    response.body
    content = Nokogiri::HTML(response.body)
    links = content.css('a.storylink').map { |link| link }

    links.each_with_index do |link, idx|
      Link.create(content: link.content, url: link['href'], rank: idx + 1)
    end
  end
end
