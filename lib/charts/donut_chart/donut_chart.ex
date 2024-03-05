defprotocol Charts.DonutChart do
  @type data_container :: Charts.chart() | Charts.DonutChart.Dataset.t()

  @spec progress(data_container) :: non_neg_integer()
  def progress(chart)

  @spec data(data_container) :: Charts.DonutChart.Dataset.t()
  def data(chart)
end
