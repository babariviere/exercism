defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, position)
      when direction in @directions and tuple_size(position) == 2 and
             is_integer(elem(position, 0)) and is_integer(elem(position, 1)) do
    %{direction: direction, position: position}
  end

  def create(direction, _position) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(%{direction: direction} = robot, "R" <> rest) do
    simulate(%{robot | direction: turn_right(direction)}, rest)
  end

  def simulate(%{direction: direction} = robot, "L" <> rest) do
    simulate(%{robot | direction: turn_left(direction)}, rest)
  end

  def simulate(%{direction: direction, position: position} = robot, "A" <> rest) do
    simulate(%{robot | position: advance(position, direction)}, rest)
  end

  def simulate(_robot, <<_instr::binary-1, _rest::binary>>) do
    {:error, "invalid instruction"}
  end

  def simulate(robot, "") do
    robot
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end

  defp turn_left(direction) do
    idx = Enum.find_index(@directions, fn x -> x == direction end)
    Enum.fetch!(@directions, rem(idx + 4 - 1, 4))
  end

  defp turn_right(direction) do
    idx = Enum.find_index(@directions, fn x -> x == direction end)
    Enum.fetch!(@directions, rem(idx + 1, 4))
  end

  defp advance({x, y}, direction) do
    case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end
end
