require "active_model"

class Rvr
  include ActiveModel::Validations

  attr_accessor :regon

  validates :regon, presence: true, numericality: true
  validate :check_length
  validate :checksum

  def initialize(value)
    self.regon = value
  end

  def regon=(value)
    @regon = value.to_s.delete(" ").delete("-")
  end

  private
  def check_length
    errors.add(:regon) unless regon.size == 9 || regon.size == 14
  end

  def checksum
    errors.add(:regon) unless control_number == regon[8].to_i
  end

  def control_number
    s = 0
    (0..7).each { |i| s += (regon[i].to_i*control_array[i]) }
    s % 11 == 10 ? 0 : s % 11
  end

  def control_array
    [8, 9, 2, 3, 4, 5, 6, 7]
  end
end

