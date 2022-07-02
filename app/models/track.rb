class Track < ApplicationRecord
  belongs_to :playlist

  enum status: {on_queue:0 , played: 1}
end
