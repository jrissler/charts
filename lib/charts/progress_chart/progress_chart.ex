defprotocol Charts.ProgressChart do
  @type data_container :: Charts.chart() | Charts.ProgressChart.Dataset.t()

  @spec progress(data_container) :: non_neg_integer()
  def progress(chart)

  @spec data(data_container) :: Charts.ProgressChart.Dataset.t()
  def data(chart)
end
