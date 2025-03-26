class Instrument < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :comment, presence: true, length: { maximum: 65_535 }
  validates :instrument_image, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy

  mount_uploader :instrument_image, InstrumentImageUploader

  enum :kind, { not_selected: 0, violin: 1, viola: 2, cello: 3, contra_bass: 4, acoustic_guitar: 5,
                electric_guitar: 6, electric_bass: 7, piano: 8, keyboard: 9, flute: 10,
                piccolo: 11, clarinet: 12, saxophone: 13, oboe: 14, english_horn: 15,
                fagott: 16, trumpet: 17, trombone: 18, horn: 19, euphonium: 20,
                tuba: 21, drum: 22, keyboard_percussion: 23, other_percussion: 24, other_strings: 25,
                other_wind_instrument: 26, japanese_instrument: 27 }
end
