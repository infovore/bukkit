require 'spec_helper'

describe PhoneNumber do
  describe "being given a raw phonenumber to convert" do
    it "should handle a phone number with a 0 correctly" do
      number = "020312345678"
      PhoneNumber.from_raw_number(number).should == "20312345678"
    end
    it "should handle a phone number with two zeroes correctly" do
      number = "004420312345678"
      PhoneNumber.from_raw_number(number).should == "4420312345678"
    end
    it "should handle a phone number with a + correctly" do
      number = "+4420312345678"
      PhoneNumber.from_raw_number(number).should == "4420312345678"
    end
    it "should handle a french phone number correctly" do
      number = "0613345738"
      PhoneNumber.from_raw_number(number).should == "613345738"
    end
  end
end
