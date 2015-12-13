class Topic < ActiveRecord::Base
  include Presenter
  include Karma
  include PgSearch

  belongs_to :category
  pg_search_scope :proceed_search, against: [:title, :body], using: {tsearch: {prefix: true}}

  scope :with_category, lambda { |category_id| where(category_id: category_id) }

  default_scope { order('karma DESC') }

  def as_json(options={})
    super({ only: [:title, :original_uri, :id] }.merge(options)).tap do |json|
      json[:teaser] = self.teaser(options[:search_q].split(' '))
    end
  end

end