defmodule Charts.LollipopChartTest do
  @moduledoc false

  alias Charts.Axes.{BaseAxes, MagnitudeAxis}
  alias Charts.BaseChart
  alias Charts.LollipopChart
  alias Charts.LollipopChart.{Dataset, Datum, Lollipop}

  use ExUnit.Case

  @x_axis %MagnitudeAxis{min: 0, max: 100}
  @axes %BaseAxes{magnitude_axis: @x_axis}
  @data [
    %Datum{name: "Condition One", value: 20, fill_color: :blue, metadata: %{count: 10, total: 50}},
    %Datum{name: "Condition Two", value: 50, fill_color: :green, metadata: %{count: 25, total: 50}},
    %Datum{name: "Condition Three", value: 80, fill_color: :red, metadata: %{count: 40, total: 50}},
    %Datum{name: "Condition Four", value: 0, fill_color: :gray, metadata: %{count: 0, total: 50}}
  ]
  @dataset %Dataset{data: @data, axes: @axes}
  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "lollipops/1" do
    test "returns the number of lollipops that make up the dataset" do
      assert length(LollipopChart.lollipops(@chart)) == length(@data)
    end

    test "returns an empty list when the chart does not have a dataset" do
      assert LollipopChart.lollipops(%BaseChart{}) == []
    end

    test "returns an empty list when the dataset does not have data" do
      assert LollipopChart.lollipops(%BaseChart{dataset: %Dataset{data: [], axes: @axes}}) == []
    end

    test "returns lollipop labels" do
      labels = Enum.map(LollipopChart.lollipops(@chart), & &1.label)
      expected_labels = Enum.map(@data, & &1.name)

      assert labels == expected_labels
    end

    test "returns lollipop original values" do
      values = Enum.map(LollipopChart.lollipops(@chart), & &1.value)
      expected_values = Enum.map(@data, & &1.value)

      assert values == expected_values
    end

    test "returns lollipop fill colors" do
      fill_colors = Enum.map(LollipopChart.lollipops(@chart), & &1.fill_color)
      expected_fill_colors = Enum.map(@data, & &1.fill_color)

      assert fill_colors == expected_fill_colors
    end

    test "returns lollipop metadata" do
      metadata = Enum.map(LollipopChart.lollipops(@chart), & &1.metadata)
      expected_metadata = Enum.map(@data, & &1.metadata)

      assert metadata == expected_metadata
    end

    test "returns evenly distributed row heights" do
      heights = Enum.map(LollipopChart.lollipops(@chart), & &1.height)

      assert Enum.all?(heights, &(&1 == 25.0))
    end

    test "returns correct row offsets" do
      offsets = Enum.map(LollipopChart.lollipops(@chart), & &1.offset)

      assert offsets == [0.0, 25.0, 50.0, 75.0]
    end

    test "returns vertically centered stem offsets" do
      stem_offsets = Enum.map(LollipopChart.lollipops(@chart), & &1.stem_offset)

      assert stem_offsets == [12.5, 37.5, 62.5, 87.5]
    end

    test "calculates stem widths as a percentage of the magnitude axis" do
      stem_widths = Enum.map(LollipopChart.lollipops(@chart), & &1.stem_width)

      assert stem_widths == [20.0, 50.0, 80.0, 0.0]
    end

    test "calculates dot offsets as a percentage of the magnitude axis" do
      dot_offsets = Enum.map(LollipopChart.lollipops(@chart), & &1.dot_offset)

      assert dot_offsets == [20.0, 50.0, 80.0, 0.0]
    end

    test "accounts for a non-zero magnitude-axis minimum" do
      chart = %BaseChart{
        title: "title",
        dataset: %Dataset{
          axes: %BaseAxes{magnitude_axis: %MagnitudeAxis{min: 20, max: 100}},
          data: [
            %Datum{name: "Minimum", value: 20},
            %Datum{name: "Middle", value: 60},
            %Datum{name: "Maximum", value: 100}
          ]
        }
      }

      dot_offsets = Enum.map(LollipopChart.lollipops(chart), & &1.dot_offset)

      assert dot_offsets == [0.0, 50.0, 100.0]
    end

    test "returns complete lollipop display properties" do
      [first | _] = LollipopChart.lollipops(@chart)

      expected = %Lollipop{
        height: 25.0,
        offset: 0.0,
        label: "Condition One",
        stem_offset: 12.5,
        stem_width: 20.0,
        dot_offset: 20.0,
        fill_color: :blue,
        value: 20,
        metadata: %{count: 10, total: 50}
      }

      assert first == expected
    end
  end
end
