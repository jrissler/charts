defmodule Charts.BubbleMatrixChart.Bubble do
  @moduledoc """
  A struct representing bubble-level display properties.
  """

  defstruct [
    :label,
    :x,
    :y,
    :x_offset,
    :y_offset,
    :radius,
    :fill_color,
    :value,
    :metadata
  ]

  @type t() :: %__MODULE__{
          label: String.t(),
          x: Charts.BubbleMatrixChart.Datum.category(),
          y: Charts.BubbleMatrixChart.Datum.category(),
          x_offset: Float.t(),
          y_offset: Float.t(),
          radius: Float.t(),
          fill_color: atom(),
          value: number(),
          metadata: map()
        }
end
