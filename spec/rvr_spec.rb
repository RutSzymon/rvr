require 'spec_helper'

describe Rvr do
  describe "via validations" do
    it "should verify presence of regon" do
      @nvr = Rvr.new(nil)
      @nvr.should_not be_valid
    end

    context "should verify length of regon" do
      it { Rvr.new("12345").should_not be_valid }

      it { Rvr.new("1234567890").should_not be_valid }
    end

    context "should verify numericality of regon" do
      it { Rvr.new("abcdefghij").should_not be_valid }

      it { Rvr.new("12345678a0").should_not be_valid }
    end

    it "regon always should be a string" do
      @nvr = Rvr.new(1234567890)
      @nvr.regon.should eq("1234567890")
    end

    it "should remove all spaces from regon" do
      @nvr = Rvr.new("123 45 67 890")
      @nvr.regon.should eq("1234567890")
    end

    it "should remove all dashes from regon" do
      @nvr = Rvr.new("123-45-67-890")
      @nvr.regon.should eq("1234567890")
    end

    context "checksum" do
      it "shouldn't accept incorrect regon number" do
        Rvr.new("1234567890").should_not be_valid
      end

      context "should accept correct regon numbers" do
        it { Rvr.new("472836141").should be_valid }

        it { Rvr.new("000515780").should be_valid }

        it { Rvr.new("14-00-92-077").should be_valid }
      end
    end
  end
end