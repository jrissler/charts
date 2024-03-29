defimpl Charts.StackedColumnChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.StackedColumnChart.MultiColumn
  alias Charts.StackedColumnChart.Rectangle
  alias Charts.ColumnChart.Dataset

  def columns(%BaseChart{dataset: nil}), do: []
  def columns(%BaseChart{dataset: dataset}), do: columns(dataset)
  def columns(%Dataset{data: []}), do: []

  def columns(%Dataset{data: data, axes: %{magnitude_axis: %{max: max}}}) do
    width = 100.0 / Enum.count(data)
    margin = width / 4.0

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * width
      column_height = Enum.sum(values(datum.values)) / max * 100

      %MultiColumn{
        width: width,
        column_height: column_height,
        offset: offset,
        label: datum.name,
        column_width: width / 2.0,
        column_offset: offset + margin,
        parts: datum.values
      }
    end)
  end

  def rectangles(chart) do
    chart
    |> columns()
    |> rectangles_from_columns()
  end

  defp rectangles_from_columns([]), do: []

  defp rectangles_from_columns(multi_columns) do
    Enum.flat_map(multi_columns, &build_rectangles_for_column(&1))
  end

  defp build_rectangles_for_column(column) do
    column.parts
    |> Enum.reject(fn {_color, value} -> value == 0 end)
    |> Enum.reduce([], fn {color, value}, acc ->
      percentage = value / Enum.sum(values(column.parts)) * 100
      rectangle_height = percentage / 100 * column.column_height

      case acc do
        [previous | _rectangles] ->
          new_rectangle = %Rectangle{
            x_offset: column.column_offset,
            y_offset: previous.y_offset - rectangle_height,
            fill_color: color,
            width: column.width,
            height: rectangle_height,
            label: value
          }

          [new_rectangle | acc]

        [] ->
          new_rectangle = %Rectangle{
            x_offset: column.column_offset,
            y_offset: 100 - rectangle_height,
            fill_color: color,
            width: column.width,
            height: rectangle_height,
            label: value
          }

          [new_rectangle]
      end
    end)
  end

  defp values(values) when is_map(values), do: Map.values(values)
  defp values(values), do: Keyword.values(values)
end
