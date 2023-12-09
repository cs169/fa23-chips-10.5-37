# frozen_string_literal: true

require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    # selected_index = params[:selected_article_index]
    # selected_article = params[:articles][selected_index]
    # @news_item = NewsItem.new
    # @news_item = NewsItem.new(
    #     title: selected_article[:title],
    #     description: selected_article[:description],
    #     link: selected_article[:link],
    #     representative_id: params[:news_item][:representative_id],
    #     issue: params[:news_item][:issue]
    # )
    # @news_item = NewsItem.new
    # @news_item.representative_id = params[:representative_id]
    # @news_item.issue = params[:issue]
    # @news_item.title = params[:title]
    # @news_item.link = params[:link]
    # @news_item.description = params[:description]
    # puts @news_item
    # @news_item.rating = params[:rating]
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def articles
    # @news_item.NewsItem.where(representative_id: params[:representative_id]).limit(5)
    api_key = Rails.application.credentials[:NEWS_API_KEY]
    # api_call = News.new(api_key)
    # @top_articles = api_call.get_everything(
    #   q: "#{@representative.name} AND #{params[:issue]}",
    #   language: "en",
    #   sortBy: "relevancy",
    #   pageSize: 5
    # )
    # puts @top_articles
    @top_articles = search_news_api(api_key)
    Rails.logger.debug @top_articles
    if @top_articles.empty?
      redirect_to representative_news_items_path(@representative), alert: 'No articles found for this issue.'
    else
      render 'my_news_items/articles'
    end
  end

  def search_news_api(api_key)
    selected_name = Representative.find(params[:news_item][:representative_id]).name
    Rails.logger.debug selected_name
    uri = URI("https://newsapi.org/v2/everything?q=#{selected_name}%20#{params[:issue]}&language=en&sortBy=relevancy&pageSize=5&apiKey=#{api_key}")
    response = Net::HTTP.get_response(uri)
    parse_response = JSON.parse(response.body)['articles']
    @top_articles = parse_response
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def set_issues_list
    @issues_list = NewsItem.issues_list
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    # params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
