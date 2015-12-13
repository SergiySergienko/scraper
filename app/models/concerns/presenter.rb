module Presenter
  include ActionView::Helpers::TextHelper
  extend ActiveSupport::Concern

  included do

    def teaser(keywords)
      result = ""
      self.body.gsub(/[.?!]/, '\0|').split("|").map(&:strip).each do |sentence|
        result += "#{highlight(sentence, keywords)}" if keywords.any? { |kword| sentence.downcase.include?(kword.downcase) }
      end
      result
    end

  end

end