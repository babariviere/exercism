defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    convert = fn
      ?G -> ?C
      ?C -> ?G
      ?T -> ?A
      ?A -> ?U
    end

    Enum.map(dna, convert)
  end
end
