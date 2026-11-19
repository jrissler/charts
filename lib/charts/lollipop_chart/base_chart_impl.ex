defimpl Charts.LollipopChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.LollipopChart.{Dataset, Lollipop}

  def lollipops(%BaseChart{dataset: nil}), do: []
  def lollipops(%BaseChart{dataset: dataset}), do: do_lollipops(dataset)
  defp do_lollipops(%Dataset{data: []}), do: []

  defp do_lollipops(%Dataset{data: data, axes: %{magnitude_axis: %{min: min, max: max}}}) do
    height = 100.0 / Enum.count(data)
    range = max - min

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * height
      dot_offset = (datum.value - min) / range * 100.0

      %Lollipop{
        height: height,
        offset: offset,
        label: datum.name,
        stem_offset: offset + height / 2.0,
        stem_width: dot_offset,
        dot_offset: dot_offset,
        fill_color: datum.fill_color,
        value: datum.value,
        metadata: datum.metadata
      }
    end)
  end
end
