require_relative 'processors/subcategory'
require_relative 'processors/article_link'
require_relative 'processors/article_data'

class DataProcessor

  SITE_URI = 'http://bloomberg.com/'

  def self.get_subcategories(page_url)
    proceed_url_with(page_url, Processors::Subcategory.new)
  end

  def self.get_article_links(page_url)
    proceed_url_with(page_url, Processors::ArticleLink.new)
  end

  def self.get_article_data(page_url)
    proceed_url_with(page_url, Processors::ArticleData.new)
  end

  protected

  def self.proceed_url_with(page_url, processor_instance)
    proceed_data_with(Mechanize.new.get(URI(page_url)), processor_instance)
  end

  def self.proceed_data_with(document, processor_instance)
    processor_instance.proceed(document)
  end

end