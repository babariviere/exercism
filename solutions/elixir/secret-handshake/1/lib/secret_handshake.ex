defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    apply_command(code)
  end

  @wink 0b1
  @blink 0b10
  @eyes 0b100
  @jump 0b1000
  @reverse 0b10000

  # Check if integer has bit set.
  defp has_bit(n, bit), do: (n &&& bit) == bit

  # Apply a command
  defp apply_command(code, result \\ []) do
    cond do
      has_bit(code, @jump) -> apply_command(code ^^^ @jump, ["jump" | result])
      has_bit(code, @eyes) -> apply_command(code ^^^ @eyes, ["close your eyes" | result])
      has_bit(code, @blink) -> apply_command(code ^^^ @blink, ["double blink" | result])
      has_bit(code, @wink) -> apply_command(code ^^^ @wink, ["wink" | result])
      # apply reverse only when all other commands are done
      has_bit(code, @reverse) -> apply_command(code ^^^ @reverse, Enum.reverse(result))
      true -> result
    end
  end
end
