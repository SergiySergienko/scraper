require_relative "../../lib/data_processor"

class BloombergWorker
  include Sidekiq::Worker

  def perform(category_name, page_uri)
    category = Category.where(name: category_name).first
    columns = [:category_id, :original_uri, :title, :body]
    values = []

    DataProcessor.get_article_links(page_uri).each do |article_link_data|
      begin
        article_url = article_link_data[1]
        article_data = DataProcessor.get_article_data(article_url)
        next if article_data.empty?

        unless values.any? { |val| val[2] == article_data[0] }
          values << [category.id, article_url].concat(article_data)
        end

      rescue => e
        puts "Error :: #{e.message}"
        next
      end
    end

    Topic.import columns, values # bulk import

  end

end