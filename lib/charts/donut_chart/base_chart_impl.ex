defimpl Charts.DonutChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.DonutChart.DonutSlice
  alias Charts.DonutChart.Dataset

  # svg circles start at 3 o'clock position, we're moving it back 25% to top
  @initial_offset 25

  def slices(%BaseChart{dataset: nil}), do: []
  def slices(%BaseChart{dataset: dataset}), do: slices(dataset)

  def slices(%Dataset{data: []}), do: []

  def slices(%Dataset{data: data}) do
    total =
      data
      |> Enum.map(&hd(&1.values))
      |> Enum.sum()

    Enum.reduce(data, [], fn datum, acc -> [add_donut_slice(datum, acc, total) | acc] end)
  end

  defp add_donut_slice(datum, acc, total) do
    # / always returns float
    length = Kernel./(total, hd(datum.values))

    previous_offsets =
      acc
      |> Enum.map(& &1.value)
      |> Enum.sum()

    current_offset = 100 - previous_offsets + @initial_offset

    %DonutSlice{
      label: datum.name,
      value: length,
      fill_color: "12",
      stroke_dasharray: "#{length} #{100 - length}",
      stroke_dashoffset: "#{current_offset}"
    }
  end
end
