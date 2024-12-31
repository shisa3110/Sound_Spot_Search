class Spot < ApplicationRecord
  enum category: { studio:0, karaoke:1, public_facilities:2 }
end
