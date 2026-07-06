defmodule Charts.BubbleMatrixChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a bubble matrix chart.
  """

  defstruct [:x_categories, :y_categories, :data]

  @type t() :: %__MODULE__{
          x_categories: list(Charts.BubbleMatrixChart.Datum.category()),
          y_categories: list(Charts.BubbleMatrixChart.Datum.category()),
          data: list(Charts.BubbleMatrixChart.Datum.t())
        }
end
