require "active_model"

class Rvr
  include ActiveModel::Validations

  attr_accessor :regon

  validates :regon, presence: true, numericality: true, length: { is: 9 }
  validate :checksum

  def initialize(value)
    self.regon = value
  end

  def regon=(value)
    @regon = value.to_s.delete(" ").delete("-")
  end

  private
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

