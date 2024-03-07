defmodule Charts.DonutChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a Charts Donut chart.
  """
  defstruct [:data]

  @type t() :: %__MODULE__{
          data: list(Charts.BaseDatum.t())
        }
end
