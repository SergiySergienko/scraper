# Parse document for article data
# Return <Array>:[title, body]
# require 'html/sanitizer'
module Processors
  class ArticleData

    def proceed(document)
      fetch_article_data_from(document) || []
    end

    private

    def fetch_article_data_from(doc)
      title = doc.search("//h1[@class='lede-headline']/span[@class='lede-headline__highlighted']").text.strip
      body = doc.search("//section[@class='article-body']/div[@class='article-body__content']").inner_html
      body = ActionView::Base.full_sanitizer.sanitize(body)
      [title, body]
    end

  end
end