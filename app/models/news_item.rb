# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.issues_list
    ['Free Speech', 'Immigration', 'Terrorism', "Social Security and
Medicare", 'Abortion', 'Student Loans', 'Gun Control', 'Unemployment',
     'Climate Change', 'Homelessness', 'Racism', 'Tax Reform', "Net
Neutrality", 'Religious Freedom', 'Border Security', 'Minimum Wage',
     'Equal Pay']
  end

  def self.search_news_api(api_key, params, name)
    uri = URI("https://newsapi.org/v2/everything?q=#{name}%20#{params[:issue]}&sortBy=popularity&pageSize=5&apiKey=#{api_key}")
    response = Net::HTTP.get_response(uri)
    parse_response = JSON.parse(response.body)['articles']
    articles = []
    5.times do |article|
      result = parse_response[article]
      hash = {
        title:       article['title'],
        url:         article['url'],
        description: article['description']
      }
      articles_list[article] = hash
    end
    render('edit_news_item')
  end
end
