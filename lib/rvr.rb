require "active_model"

class Rvr
  include ActiveModel::Validations

  attr_accessor :regon

  validates :regon, presence: true, numericality: true
  validate :check_length
  validate :checksum, if: :regon?

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

  def regon?
    !regon.blank?
  end

  def checksum
    errors.add(:regon) unless control_number == regon[regon.length-1].to_i
  end

  def control_number
    r = regon.split("")
    s = control_array.inject(0) { |sum, a| sum += a*r.shift.to_i }
    s % 11 == 10 ? 0 : s % 11
  end

  def control_array
    regon.length == 9 ? [8, 9, 2, 3, 4, 5, 6, 7] : [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8]
  end
end

