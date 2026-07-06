defmodule Charts.LollipopChart.Lollipop do
  @moduledoc """
  A struct representing lollipop-level display properties.
  """

  defstruct [:height, :offset, :label, :stem_offset, :stem_width, :dot_offset, :fill_color, :value, :metadata]

  @type t() :: %__MODULE__{
          height: Float.t(),
          offset: Float.t(),
          label: String.t(),
          stem_offset: Float.t(),
          stem_width: Float.t(),
          dot_offset: Float.t(),
          fill_color: atom(),
          value: number(),
          metadata: map()
        }
end
