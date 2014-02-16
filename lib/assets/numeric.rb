class Numeric
  # same potential floating point problem as round_to
  def truncate_to(decimals = 0)
    factor = 10.0**decimals
    (self*factor).floor / factor
  end
  
  def numdec
    factor = 10.0
    inc = 0
    salir = false
    while salir == false do
      if ((self*(factor**inc)) % 1) > 0
        inc += 1
      else
        salir = true
      end
    end
    return inc
  end
end