# Parse document for news subcategories links
# Return <Array>:[title, href]
module Processors
  class Subcategory

    def proceed(document)
      get_filtered(document).map do |l|
        l_href = (l.href.include?('http://') ? l.href : "#{DataProcessor::SITE_URI}#{l.href}")
        [l.text.strip, l_href]
      end
    end

    private

    def get_filtered(document)
      document.links.find_all { |l| is_sub_category?(l) } || []
    end

    def is_sub_category?(a_element)
      return (a_element.attributes.parent.name == 'li' &&
          a_element.attributes.parent.parent['class'] == 'navigation-submenu__categories' &&
          a_element.attributes.parent.parent.parent['id'] == 'news')
    end

  end
end