class MainController < ApplicationController

  def index
    @categories = Category.all
  end

  def find
    respond_to do |format|
      format.json { render json: fetch_topics_json }
    end
  end

  def vote_up
    Topic.find(params[:id]).try(:up_karma!)
    redirect_to root_path
  end

  def vote_down
    Topic.find(params[:id]).try(:down_karma!)
    redirect_to root_path
  end

  private

  def fetch_topics_json
    if params[:category].present?
      return Topic.proceed_search(params[:keywords]).with_category(params[:category]).as_json(search_q: params[:keywords])
    end
    Topic.proceed_search(params[:keywords]).as_json(search_q: params[:keywords])
  end

end
