defmodule Charts.Axes.BaseAxes do
  @moduledoc """
  A defaultstruct implementation to represent configuration for axes.
  """
  defstruct [:magnitude_axis, show_gridlines: true]

  @type t() :: %__MODULE__{
          magnitude_axis: Charts.Axes.MagnitudeAxis.t() | nil,
          show_gridlines: boolean()
        }
end
