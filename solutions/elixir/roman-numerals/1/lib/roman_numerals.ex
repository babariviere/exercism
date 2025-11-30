defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    cond do
      number >= 1000 -> String.duplicate("M", floor(number / 1000)) <> numeral(rem(number, 1000))
      number >= 900 -> "CM" <> numeral(rem(number, 900))
      number >= 500 -> "D" <> numeral(rem(number, 500))
      number >= 400 -> "CD" <> numeral(rem(number, 400))
      number >= 100 -> String.duplicate("C", floor(number / 100)) <> numeral(rem(number, 100))
      number >= 90 -> "XC" <> numeral(rem(number, 90))
      number >= 50 -> "L" <> numeral(rem(number, 50))
      number >= 40 -> "XL" <> numeral(rem(number, 40))
      number >= 10 -> String.duplicate("X", floor(number / 10)) <> numeral(rem(number, 10))
      number == 9 -> "IX"
      number >= 5 -> "V" <> numeral(rem(number, 5))
      number == 4 -> "IV"
      number >= 1 -> String.duplicate("I", floor(number / 1))
      true -> ""
    end
  end
end
