# Parse document for articles links
# Return <Array>:[title, href]
module Processors
  class ArticleLink

    def proceed(document)
      get_filtered(document).map do |l|
        l_href = (l.href.include?('http://') ? l.href : "#{DataProcessor::SITE_URI}#{l.href}")
        [l.text.strip, l_href]
      end
    end

    private

    def get_filtered(document)
      document.links.find_all { |l| is_article_link?(l) } || []
    end

    def is_article_link?(a_element)
      return (a_element.attributes['data-resource-type'] == 'article')
    end

  end
end