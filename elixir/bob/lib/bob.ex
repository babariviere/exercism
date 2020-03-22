defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    uppercase = String.upcase(input)
    yelling? = uppercase != String.downcase(input) and uppercase == input

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
