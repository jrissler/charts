defmodule Charts.DonutChartTest do
  use ExUnit.Case

  alias Charts.BaseChart
  alias Charts.Gradient
  alias Charts.DonutChart
  alias Charts.DonutChart.Dataset

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
    dataset: %Dataset{
      background_stroke_color: :gray,
      label: "A Nice Second Title",
      secondary_label: "Secondary label",
      to_value: 100,
      current_value: 50,
      percentage_text_fill_color: :blue_gradient,
      percentage_fill_color: :light_blue_gradient,
      label_fill_color: :blue_gradient
    }
  }

  describe "data/1" do
    test "takes a base chart with a valid progress chart dataset and returns the dataset" do
      assert DonutChart.data(@chart) == @chart.dataset
    end

    test "takes a progress dataset and passes it through unchanged" do
      assert DonutChart.data(@chart.dataset) == @chart.dataset
    end

    test "returns an empty map if a chart's dataset is nil" do
      assert DonutChart.data(%BaseChart{dataset: nil}) == %{}
    end
  end

  describe "progress/1" do
    test "takes a base chart with progress chart dataset and returns the percentage of progress" do
      assert DonutChart.progress(@chart) == 50
    end

    test "takes a progress chart dataset and returns the percentage of progress" do
      assert DonutChart.progress(@chart.dataset) == 50
    end

    test "returns zero if given a chart with an empty dataset" do
      assert DonutChart.progress(%BaseChart{dataset: nil}) == 0
    end
  end
end
