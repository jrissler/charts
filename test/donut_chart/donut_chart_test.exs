defmodule Charts.DonutChartTest do
  use ExUnit.Case

  alias Charts.BaseChart
  alias Charts.BaseDatum
  alias Charts.DonutChart
  alias Charts.DonutChart.Dataset
  alias Charts.DonutChart.DonutSlice
  alias Charts.Gradient

  @data [
    %BaseDatum{
      name: "slice 1",
      values: [10]
    },
    %BaseDatum{
      name: "slice 2",
      values: [20]
    },
    %BaseDatum{
      name: "slice 3",
      values: [30]
    },
    %BaseDatum{
      name: "slice 4",
      values: [40]
    },
    %BaseDatum{
      name: "slice 5",
      values: [50]
    }
  ]
  @chart %BaseChart{
    title: "A Nice Title",
    colors: %{
      gray: "#ececec",
      light_blue_gradient: %Gradient{
        start_color: "#008fb1",
        end_color: "#00d9e9"
      },
      blue_gradient: %Gradient{
        start_color: "#0052a7",
        end_color: "#005290"
      }
    },
    dataset: %Dataset{data: @data}
  }

  describe "slices/1" do
    test "takes a base chart with nil dataset and returns the empty list" do
      assert DonutChart.slices(%BaseChart{dataset: nil}) == []
    end

    test "takes a base chart with a empty data and returns the empty list" do
      assert DonutChart.slices(%BaseChart{dataset: %Dataset{data: []}}) == []
    end

    test "takes a base chart with a valid donut chart dataset and returns the dataset" do
      chart_data = DonutChart.slices(@chart)
      assert length(chart_data) == length(@data)

      last_slice = List.last(chart_data)

      assert last_slice == %DonutSlice{
               label: "slice 1",
               value: 15.0,
               percentage: nil,
               fill_color: "12",
               stroke_dasharray: "15.0 85.0",
               stroke_dashoffset: "125"
             }
    end
  end
end
