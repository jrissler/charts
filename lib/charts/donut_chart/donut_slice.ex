defmodule Charts.DonutChart.DonutSlice do
  @moduledoc """
  A struct representing donut chart slice display properties.
  """

  defstruct [:label, :value, :percentage, :fill_color, :stroke_dasharray, :stroke_dashoffset]

  @type t() :: %__MODULE__{
          label: String.t(),
          value: Float.t(),
          fill_color: atom(),
          stroke_dasharray: String.t(),
          stroke_dashoffset: String.t()
        }
end
