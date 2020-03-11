defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(~r/[^[:alnum:]-]/u, trim: true)
    |> Enum.reduce(%{}, fn word, map -> Map.update(map, String.downcase(word), 1, &(&1 + 1)) end)
  end
end
