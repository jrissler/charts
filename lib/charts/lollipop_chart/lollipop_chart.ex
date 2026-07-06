defprotocol Charts.LollipopChart do
  @spec lollipops(Charts.chart() | Charts.LollipopChart.Dataset.t()) ::
          list(Charts.LollipopChart.Lollipop.t())
  @doc """
  Returns a list of the `Charts.LollipopChart.Lollipop.t()` that should be rendered by the chart display adapter.
  """
  def lollipops(chart)
end
