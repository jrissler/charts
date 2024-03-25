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

    data
    |> Enum.reduce([], fn datum, acc -> [add_donut_slice(datum, acc, total) | acc] end)
    |> Enum.reverse()
  end

  defp add_donut_slice(datum, acc, total) do
    length =
      datum.values
      |> hd()
      |> Kernel./(total)
      |> Kernel.*(100)

    previous_offsets =
      acc
      |> Enum.map(& &1.value)
      |> Enum.sum()

    current_offset =
      case previous_offsets do
        0 -> @initial_offset
        _ -> 100 - previous_offsets + @initial_offset
      end

    %DonutSlice{
      label: "#{datum.name} (#{hd(datum.values)})",
      value: length,
      fill_color: datum.fill_color,
      stroke_dasharray: "#{length} #{100 - length}",
      stroke_dashoffset: "#{current_offset}"
    }
  end
end
