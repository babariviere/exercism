defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    rot = fn
      x when x in ?a..?z -> rem(x - ?a + shift, 26) + ?a
      x when x in ?A..?Z -> rem(x - ?A + shift, 26) + ?A
      x -> x
    end

    text
    |> to_charlist()
    |> Enum.map(rot)
    |> to_string()
  end
end
