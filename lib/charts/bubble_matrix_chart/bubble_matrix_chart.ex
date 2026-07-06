defprotocol Charts.BubbleMatrixChart do
  @spec bubbles(Charts.chart() | Charts.BubbleMatrixChart.Dataset.t()) ::
          list(Charts.BubbleMatrixChart.Bubble.t())
  @doc """
  Returns a list of the `Charts.BubbleMatrixChart.Bubble.t()` that should be rendered by the chart display adapter.
  """
  def bubbles(chart)

  @spec x_categories(Charts.chart() | Charts.BubbleMatrixChart.Dataset.t()) ::
          list(Charts.BubbleMatrixChart.Datum.category())
  @doc """
  Returns the ordered categories displayed on the horizontal axis.
  """
  def x_categories(chart)

  @spec y_categories(Charts.chart() | Charts.BubbleMatrixChart.Dataset.t()) ::
          list(Charts.BubbleMatrixChart.Datum.category())
  @doc """
  Returns the ordered categories displayed on the vertical axis.
  """
  def y_categories(chart)
end
