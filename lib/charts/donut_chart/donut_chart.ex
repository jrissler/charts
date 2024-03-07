defprotocol Charts.DonutChart do
  @spec slices(Charts.chart() | Charts.DonutChart.Dataset.t()) ::
          list(Charts.DonutChart.DonutSlice.t())

  @doc """
  Returns a list of the `Charts.DonutChart.DonutSlice.t()` that should be rendered by the chart display adapter
  """
  def slices(chart)
end
