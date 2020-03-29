class ResistorColorDuo
  COLORS = {
    'black' => 0,
    'brown' => 1,
    'red' => 2,
    'orange' => 3,
    'yellow' => 4,
    'green' => 5,
    'blue' => 6,
    'violet' => 7,
    'grey' => 8,
    'white' => 9
  }.freeze

  def self.value(colors)
    colors.take(2).reduce(0) do |acc, color|
      acc * 10 + COLORS[color]
    end
  end
end
