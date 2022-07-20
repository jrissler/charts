defimpl Charts.ProgressChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.ProgressChart.Dataset

  def progress(%BaseChart{dataset: nil}), do: 0

  def progress(%BaseChart{dataset: %Dataset{} = dataset}) do
    round(100 * dataset.current_value / dataset.to_value)
  end

  def data(%BaseChart{dataset: nil}), do: %{}
  def data(%BaseChart{dataset: dataset}), do: dataset
end

defimpl Charts.ProgressChart, for: Charts.ProgressChart.Dataset do
  alias Charts.ProgressChart.Dataset
  def data(%Dataset{} = data), do: data

  def progress(%Dataset{to_value: to_value, current_value: current_value}) do
    round(100 * current_value / to_value)
  end
end
