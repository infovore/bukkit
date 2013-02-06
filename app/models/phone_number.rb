class PhoneNumber
  class << self
    def from_raw_number(number)
      n = number.strip.gsub(" ", "")

      if n[0,2] == "00"
        # chop that off
        n = n[2, n.length]
      elsif n.first == "0"
        # chop the zero off
        n = n[1,n.length]
      elsif n.first == "+"
        # chop the plus off
        n = n[1,n.length]
      end
      n
    end
  end
end
