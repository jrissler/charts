defimpl Charts.ColumnChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.ColumnChart.{Column, Dataset}

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
      column_height = hd(datum.values) / max * 100

      %Column{
        label: datum.name,
        width: width,
        offset: offset,
        column_offset: offset + margin,
        column_width: width / 2.0,
        column_height: column_height,
        fill_color: datum.fill_color
      }
    end)
  end
end
