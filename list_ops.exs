defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  def count([]), do: 0
  def count([], n), do: n
  def count([_|tail], n), do: count(tail, n + 1)

  @spec reverse(list) :: list
  def reverse(l), do:  reverse(l, [])
  def reverse([head|tail], acc), do: reverse(tail, [head | acc])
  def reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map([h | t], f), do: [f.(h) | map(t, f)]
  def map([], f), do: []

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([h | t], f) do
    if f.(h) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end
  def filter([], f), do: []

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _),    do: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(a, b), do: a ++ b
  def append([], _), do: []
  def append(_, []), do: []

  @spec concat([[any]]) :: [any]
  def concat(list) do
    append = &[&1|&2]
    reduce(list, [], &reduce(&1, &2, append)) |> reverse
  end

end

