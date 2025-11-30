defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    # 1. match all non lowercase
    # 2. match first uppercase
    # 3. match all non lowercase
    yelling? = String.match?(input, ~r/^[^\p{Ll}]*\p{Lu}[^\p{Ll}]*$/u)

    question? =
      input
      |> String.trim_trailing()
      |> String.last() == "?"

    cond do
      input == "" ->
        "Fine. Be that way!"

      yelling? and question? ->
        "Calm down, I know what I'm doing!"

      yelling? ->
        "Whoa, chill out!"

      question? ->
        "Sure."

      true ->
        "Whatever."
    end
  end
end
