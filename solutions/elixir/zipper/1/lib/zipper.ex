defmodule Zipper do
  alias __MODULE__, as: ZP
  alias BinTree, as: BT

  defstruct [:pos, :node, :parent]

  @type t :: %{
          # position of the node from parent
          pos: :left | :right | :top,
          node: BT.t(),
          parent: t() | nil
        }

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: ZP.t()
  def from_tree(bin_tree) do
    %ZP{
      pos: :top,
      node: bin_tree
    }
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(ZP.t()) :: BT.t()

  def to_tree(%ZP{pos: :left, node: node, parent: parent}) do
    parent_node = parent.node

    to_tree(%ZP{parent | node: %BT{parent_node | left: node}})
  end

  def to_tree(%ZP{pos: :right, node: node, parent: parent}) do
    parent_node = parent.node

    to_tree(%ZP{parent | node: %BT{parent_node | right: node}})
  end

  def to_tree(%ZP{pos: :top, node: node}), do: node

  @doc """
  Get the value of the focus node.
  """
  @spec value(ZP.t()) :: any
  def value(zipper), do: zipper.node.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(ZP.t()) :: ZP.t() | nil

  def left(%ZP{node: %BT{left: nil}}), do: nil

  def left(%ZP{node: %BT{left: left}} = parent) do
    %ZP{pos: :left, node: left, parent: parent}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(ZP.t()) :: ZP.t() | nil

  def right(%ZP{node: %BT{right: nil}}), do: nil

  def right(%ZP{node: %BT{right: right}} = parent) do
    %ZP{pos: :right, node: right, parent: parent}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(ZP.t()) :: ZP.t() | nil
  def up(%ZP{parent: parent}), do: parent

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(ZP.t(), any) :: ZP.t()
  def set_value(%ZP{node: node} = zipper, value) do
    %{zipper | node: %BT{node | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(ZP.t(), BT.t() | nil) :: ZP.t()
  def set_left(%ZP{node: node} = zipper, left) do
    %ZP{zipper | node: %{node | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(ZP.t(), BT.t() | nil) :: ZP.t()
  def set_right(%ZP{node: node} = zipper, right) do
    %ZP{zipper | node: %{node | right: right}}
  end
end
