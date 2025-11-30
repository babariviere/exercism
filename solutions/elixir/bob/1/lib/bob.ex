defmodule Bob do
  defp yelling?(input) do
    # 1. ignore all not lowercase
    # 2. match first uppercase
    # 3. match all non lowercase
    String.match?(input, ~r/^[^\p{Ll}]*\p{Lu}[^\p{Ll}]*$/u)
  end

  defp question?(input) do
    input
    |> String.trim_trailing()
    |> String.last() == "?"
  end

  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      yelling?(input) and
          question?(input) ->
        "Calm down, I know what I'm doing!"

      yelling?(input) ->
        "Whoa, chill out!"

      question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end
end
