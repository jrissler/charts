defmodule Charts.DonutChart.DonutSlice do
  @moduledoc """
  A struct representing donut chart slice display properties.
  """

  defstruct [:label, :percentage, :fill_color]

  @type t() :: %__MODULE__{
          label: String.t(),
          percentage: Float.t(),
          fill_color: atom()
        }
end
