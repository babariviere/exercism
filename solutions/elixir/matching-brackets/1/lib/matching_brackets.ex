defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> check_brackets([])
  end

  @assoc_pars [
    {"{", "}"},
    {"[", "]"},
    {"(", ")"}
  ]

  @open_pars Enum.map(@assoc_pars, fn pair -> elem(pair, 0) end)
  @close_pars Enum.map(@assoc_pars, fn pair -> elem(pair, 1) end)

  defp check_brackets([], []), do: true
  defp check_brackets([], _), do: false

  defp check_brackets([head | tail], stack) when head in @open_pars do
    check_brackets(tail, [head | stack])
  end

  defp check_brackets([head | tail], [open | stack]) when head in @close_pars do
    valid =
      Enum.find(@assoc_pars, fn x -> elem(x, 0) == open end)
      |> elem(1) == head

    case valid do
      true -> check_brackets(tail, stack)
      _ -> false
    end
  end

  defp check_brackets([head | _tail], []) when head in @close_pars, do: false
  defp check_brackets([_head | tail], stack), do: check_brackets(tail, stack)
end
