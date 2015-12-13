require_relative '../../app/workers/bloomberg_worker'

namespace :bloomberg_scraper do

  desc "Fetch news data from bloomeberg.com site"
  task fetch_data: :environment do

    subcategories = DataProcessor.get_subcategories(DataProcessor::SITE_URI)

    Category.transaction do
      old_categories_names = Category.select(:name).map(&:name)
      columns = [:name]
      values = (subcategories.map {|cat| cat[0]} - old_categories_names).map { |category| [category] }
      Category.import columns, values # bulk insert
    end

    subcategories.each do |sub_category_data|
      BloombergWorker.perform_async(sub_category_data[0], sub_category_data[1])
      sleep 1
    end

  end

end
