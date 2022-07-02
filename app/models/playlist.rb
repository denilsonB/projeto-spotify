class Playlist < ApplicationRecord
  belongs_to :user

  serialize :owner, Hash
end
