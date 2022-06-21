class SearchController < ApplicationController
  before_action :search_service, only: :search

  def search
    results = search_service.search
    json_response = {
      success: true,
      message: 'API Response',
      error: results
    }
    render json: json_response, status: 200
  end

  private

  def search_service
    @search_service = SearchService.new(search_params[:engine], search_params[:text])
  end

  def default_search_params
    {
      per_page: 10,
      page: 1
    }
  end

  def search_params
    params.permit(:engine, :text, :per_page, :page).reverse_merge(default_search_params)
  end
end
