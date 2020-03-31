defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    # Refactor: split function call with pipe
    m
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> patch
  end

  # Refactor: Handle case per function instead in one chunk
  # The string is parsed with pattern matching
  defp process("#" <> _rest = line) do
    line
    |> parse_header_md_level()
    |> enclose_with_header_tag()
  end

  defp process("* " <> _text = line) do
    parse_list_md_level(line)
  end

  defp process(line) do
    line
    |> String.split()
    |> enclose_with_paragraph_tag()
  end

  defp parse_header_md_level(line) do
    # Refactor: avoid unecessary Enum.join by reducing the split
    [header | [text]] = String.split(line, " ", parts: 2)

    # Refactor: avoid nested function call in tuple for better readability
    header_num =
      header
      |> String.length()
      |> to_string()

    {header_num, text}
  end

  # Refactor: parse list bullet with pattern matching
  defp parse_list_md_level("* " <> text) do
    # Refactor: avoid nested function call
    words =
      text
      |> String.split()
      |> join_words_with_tags()

    # Refactor: use interpolation
    "<li>#{words}</li>"
  end

  # Refactor: use string interpolation + better variable naming
  defp enclose_with_header_tag({level, text}) do
    "<h#{level}>#{text}</h#{level}>"
  end

  defp enclose_with_paragraph_tag(paragraph) do
    # Refactor: avoid long function call in interpolation
    words = join_words_with_tags(paragraph)
    "<p>#{words}</p>"
  end

  defp join_words_with_tags(words) do
    # Refactor: avoid nested call and avoid unecessary fn when you can reference function
    words
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    # Refactor: avoid nested call
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(w) do
    # Refactor: avoid complicated regex
    cond do
      String.starts_with?(w, "__") -> String.replace_prefix(w, "__", "<strong>")
      String.starts_with?(w, "_") -> String.replace_prefix(w, "_", "<em>")
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    # Refactor: avoid complicated regex
    cond do
      String.ends_with?(w, "__") -> String.replace_suffix(w, "__", "</strong>")
      String.ends_with?(w, "_") -> String.replace_suffix(w, "_", "</em>")
      true -> w
    end
  end

  defp patch(text) do
    # Refactor: avoid nested calls
    text
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix(
      "</li>",
      "</li></ul>"
    )
  end
end
