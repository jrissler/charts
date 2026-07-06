defmodule Charts.BubbleMatrixChart.Datum do
  @moduledoc """
  A struct representing a data point in a bubble matrix chart.
  """

  defstruct [:name, :x, :y, :value, :fill_color, metadata: %{}]

  @type category() :: String.t() | atom() | number()

  @type t() :: %__MODULE__{
          name: String.t(),
          x: category(),
          y: category(),
          value: number(),
          fill_color: atom(),
          metadata: map()
        }
end
