class Link < ApplicationRecord
  has_many :ranks

  def self.schedule_jobs
    for i in 1..10
    Link.delay(run_at: i.minutes.from_now).get_ranks
    end
  end

  def self.schedule_jobs_overnight
    for i in 1..900
      Link.delay(run_at: i.minutes.from_now).get_ranks
    end
  end

  def self.get_ranks
    response = HTTParty.get('https://news.ycombinator.com/')
    response.body
    content = Nokogiri::HTML(response.body)
    links = content.css('a.storylink').map { |link| link }

    links.each_with_index do |link, idx|
      existing_link = Link.find_by(url: link['href'])
      if existing_link
        Rank.create(page_rank: idx + 1, link: existing_link)
      else
        new_link = Link.create(content: link.content, url: link['href'])
        Rank.create(page_rank: idx + 1, link: new_link)
      end
    end
  end
end





# class Animal
#   def initialize(name)
#     @name = name

#   end

#   def your_class_method
#     puts "I am in the class"
#   end

#   def bark
#     puts "woof my name is #{@name}"
#   end
# end


# aaron = Animal.new

