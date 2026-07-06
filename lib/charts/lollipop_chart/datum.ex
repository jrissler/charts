defmodule Charts.LollipopChart.Datum do
  @moduledoc """
  A struct representing a data point in a lollipop chart.
  """

  defstruct [:name, :fill_color, :value, metadata: %{}]

  @type t() :: %__MODULE__{
          name: String.t(),
          fill_color: atom(),
          value: number(),
          metadata: map()
        }
end
