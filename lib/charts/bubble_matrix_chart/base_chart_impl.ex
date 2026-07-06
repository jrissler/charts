defimpl Charts.BubbleMatrixChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.BubbleMatrixChart.{Bubble, Dataset}

  @minimum_radius 2.5
  @maximum_radius 10.0

  def bubbles(%BaseChart{dataset: nil}), do: []
  def bubbles(%BaseChart{dataset: dataset}), do: bubbles(dataset)
  def bubbles(%Dataset{data: []}), do: []

  def bubbles(%Dataset{x_categories: x_categories, y_categories: y_categories, data: data}) do
    x_offsets = category_offsets(x_categories)
    y_offsets = category_offsets(y_categories)
    max = data |> Enum.map(& &1.value) |> Enum.max()

    Enum.map(data, fn datum ->
      %Bubble{
        label: datum.name,
        x: datum.x,
        y: datum.y,
        x_offset: Map.fetch!(x_offsets, datum.x),
        y_offset: Map.fetch!(y_offsets, datum.y),
        radius: radius(datum.value, max),
        fill_color: datum.fill_color,
        value: datum.value,
        metadata: datum.metadata
      }
    end)
  end

  def x_categories(%BaseChart{dataset: nil}), do: []
  def x_categories(%BaseChart{dataset: dataset}), do: x_categories(dataset)
  def x_categories(%Dataset{x_categories: nil}), do: []
  def x_categories(%Dataset{x_categories: x_categories}), do: x_categories

  def y_categories(%BaseChart{dataset: nil}), do: []
  def y_categories(%BaseChart{dataset: dataset}), do: y_categories(dataset)
  def y_categories(%Dataset{y_categories: nil}), do: []
  def y_categories(%Dataset{y_categories: y_categories}), do: y_categories

  defp category_offsets(categories) do
    size = 100.0 / Enum.count(categories)

    categories
    |> Enum.with_index()
    |> Map.new(fn {category, index} ->
      {category, index * size + size / 2.0}
    end)
  end

  defp radius(0, _max), do: 0.0
  defp radius(_value, 0), do: 0.0

  defp radius(value, max) do
    normalized_value = value / max
    @minimum_radius + :math.sqrt(normalized_value) * (@maximum_radius - @minimum_radius)
  end
end
