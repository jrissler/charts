defmodule Charts.Axes.MagnitudeAxis do
  @moduledoc """
  Exposes a struct representing configuration for an axis that has values that increase in a particular direction
  """
  defstruct [:min, :max, :step, :label, :appended_label, :format, grid_lines: &__MODULE__.default_grid_lines_fun/2]
  @type min :: number()
  @type max :: number()
  @type step :: integer()

  @typedoc """
  A function that takes a tuple with a minimum and maximum value that
  represents the min and max of a grid axis and a step value. This function
  is used to determine the spacial offsets of the labels on the axis and the
  gridlines of the chart.
  """
  @type grid_lines_func :: ({min, max}, step -> list(Float.t()))
  @type t() :: %__MODULE__{
          min: number(),
          max: number(),
          step: integer(),
          label: String.t() | nil,
          appended_label: String.t() | nil,
          format: Atom.t() | nil,
          grid_lines: grid_lines_func
        }

  @doc """
  The default function used to determine spacial offsets of labels
  along an axis, as well as `grid_lines` going across a chart.

  If you do not specify a different `grid_lines_func` function
  when you create a `Charts.Axes.MagnitudeAxis` struct, this
  implementation will be provided used.
  """
  @spec default_grid_lines_fun({min, max}, step) :: list(Float.t())
  def default_grid_lines_fun({min, max}, step) do
    rounded_max = Kernel.round(max)
    integers_to_take = div(rounded_max - min, step)
    take = if integers_to_take > 0, do: integers_to_take, else: integers_to_take * -1

    min..rounded_max
    |> Enum.take_every(take)
    |> Enum.drop(1)
  end
end
