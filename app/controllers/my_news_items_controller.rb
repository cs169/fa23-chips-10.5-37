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
    puts params[:selected_article_index]
    selected_news_index = params[:selected_news_index].to_i
    
    # @representative = Representative.find(params[:representative_id])
    # @news_item = @representative.news_items.build(news_item_params)
    # @top_articles.title = params[:news_item][:title]
    # @top_articles.description = 
    # @top_articles.issue = params[:issue] 

    if @news_item.save
      # @representative.news_items << @news_item
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

  def search_select
    @searched_issue = params[:news_item][:issue]
    @searched_rep = params[:news_item][:representative]
    # @searched_rep = Representative.find(news_item_params[:representative_id])
  end

  def search
    # news_api = News.new(Rails.application.credentials[:NEWS_API_KEY])
    # api_call = news_api.get_everything(q: "#{params[:issue]} AND #{@representative.name}", sortBy: "relevancy", pageSize: 5)
    # puts api_call
    # @top_articles = api_call
    # puts @top_articles
   
    return unless news_item_params[:representative_id].present? && news_item_params[:issue].present?

    @news_item = NewsItem.new
    api_key = Rails.application.credentials[:NEWS_API_KEY]
    @top_articles = NewsItem.search_news_api(api_key, params)
    if @top_articles.empty?
      set_issues_list
      redirect_to representative_news_items_path, alert: 'No articles found for this issue.'
    else
      render :search
    end
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
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
