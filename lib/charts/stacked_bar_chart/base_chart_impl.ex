defimpl Charts.StackedBarChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.StackedBarChart.MultiBar
  alias Charts.StackedColumnChart.Rectangle
  alias Charts.BarChart.Dataset

  @row_height 20.0
  @bar_height 14.0
  @bar_margin 3.0

  def rows(%BaseChart{dataset: nil}), do: []
  def rows(%BaseChart{dataset: dataset}), do: rows(dataset)

  def rows(%Dataset{data: []}), do: []

  def rows(%Dataset{data: data, axes: %{magnitude_axis: %{max: max}}}) do
    data
    |> Enum.with_index()
    |> Enum.map(fn
      {%{name: name, values: values}, index} -> {name, values, index}
      {{_key, %{name: name, values: values}}, index} -> {name, values, index}
    end)
    |> Enum.map(fn {name, values, index} ->
      offset = index * @row_height

      bar_width =
        if max > 0 do
          Enum.sum(value_list(values)) / max * 100
        else
          0
        end

      %MultiBar{
        height: @row_height,
        offset: offset,
        bar_width: bar_width,
        label: name,
        bar_height: @row_height,
        bar_offset: offset + @bar_margin,
        parts: values
      }
    end)
  end

  def rectangles(chart) do
    chart
    |> rows()
    |> rectangles_from_rows()
  end

  defp rectangles_from_rows([]), do: []

  defp rectangles_from_rows(multi_bars) do
    multi_bars
    |> Enum.flat_map(&build_rectangles_for_row(&1))
  end

  defp build_rectangles_for_row(row) do
    total = Enum.sum(value_list(row.parts))

    row.parts
    |> Enum.reject(fn {_color, width} -> width == 0 end)
    |> Enum.reduce([], fn {color, width}, acc ->
      percentage = width / total * 100
      rectangle_width = Float.round(percentage / 100 * row.bar_width, 2)

      case acc do
        [previous | _] ->
          new_rectangle = %Rectangle{
            x_offset: Float.round(previous.x_offset + previous.width, 2),
            y_offset: row.offset + @bar_margin,
            fill_color: color,
            width: rectangle_width,
            height: @bar_height,
            label: width
          }

          [new_rectangle | acc]

        [] ->
          new_rectangle = %Rectangle{
            x_offset: 0,
            y_offset: row.offset + @bar_margin,
            fill_color: color,
            width: rectangle_width,
            height: @bar_height,
            label: width
          }

          [new_rectangle]
      end
    end)
    |> Enum.reverse()
  end

  defp value_list(list_or_map) when is_map(list_or_map), do: Map.values(list_or_map)
  defp value_list(list_or_map) when is_list(list_or_map), do: Keyword.values(list_or_map)
end
