defmodule Charts.LollipopChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a horizontal lollipop chart.
  """

  defstruct [:axes, :data]

  @type t() :: %__MODULE__{
          axes: Charts.Axes.BaseAxes.t(),
          data: list(Charts.LollipopChart.Datum.t())
        }
end
