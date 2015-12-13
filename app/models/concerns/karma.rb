module Karma
  extend ActiveSupport::Concern

  included do

    def up_karma!
      self.karma += 1
      self.save!
    end

    def down_karma!
      self.karma -= 1
      self.save!
    end

  end

end