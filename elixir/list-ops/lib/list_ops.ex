defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: do_count(list, 0)

  defp do_count([h | t], res), do: do_count(t, res + 1)
  defp do_count([], res), do: res

  @spec reverse(list) :: list
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([h | t], res), do: do_reverse(t, [h | res])
  defp do_reverse([], res), do: res

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f, [])

  defp do_map([h | t], f, res), do: do_map(t, f, [f.(h) | res])
  defp do_map([], _f, res), do: reverse(res)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f, [])

  defp do_filter([h | t], f, res) do
    if f.(h) do
      do_filter(t, f, [h | res])
    else
      do_filter(t, f, res)
    end
  end

  defp do_filter([], _f, res), do: reverse(res)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  def reduce([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append(a, b), do: do_append(a, b, [])

  defp do_append([h | t], b, res), do: do_append(t, b, [h | res])
  defp do_append([], [h | t], res), do: do_append([], t, [h | res])
  defp do_append([], [], res), do: reverse(res)

  @spec concat([[any]]) :: [any]
  def concat(ll), do: do_concat(ll, [])

  defp do_concat([h | t], res) do
    do_concat(t, append(res, h))
  end

  defp do_concat([], res), do: res
end
