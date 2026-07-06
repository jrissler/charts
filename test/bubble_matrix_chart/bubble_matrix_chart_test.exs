defmodule Charts.BubbleMatrixChartTest do
  @moduledoc false

  alias Charts.BaseChart
  alias Charts.BubbleMatrixChart
  alias Charts.BubbleMatrixChart.{Bubble, Dataset, Datum}

  use ExUnit.Case

  @x_categories ["Procedure One", "Procedure Two", "Procedure Three"]
  @y_categories ["Group One", "Group Two", "Group Three"]

  @data [
    %Datum{
      name: "Procedure One / Group One",
      x: "Procedure One",
      y: "Group One",
      value: 25,
      fill_color: :blue,
      metadata: %{percentage: 10.0}
    },
    %Datum{
      name: "Procedure Two / Group Two",
      x: "Procedure Two",
      y: "Group Two",
      value: 100,
      fill_color: :green,
      metadata: %{percentage: 40.0}
    },
    %Datum{
      name: "Procedure Three / Group Three",
      x: "Procedure Three",
      y: "Group Three",
      value: 400,
      fill_color: :red,
      metadata: %{percentage: 80.0}
    },
    %Datum{
      name: "Procedure One / Group Three",
      x: "Procedure One",
      y: "Group Three",
      value: 0,
      fill_color: :gray
    }
  ]

  @dataset %Dataset{
    x_categories: @x_categories,
    y_categories: @y_categories,
    data: @data
  }

  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "bubbles/1" do
    test "returns the number of bubbles that make up the dataset" do
      assert length(BubbleMatrixChart.bubbles(@chart)) == length(@data)
    end

    test "returns an empty list when the chart does not have a dataset" do
      assert BubbleMatrixChart.bubbles(%BaseChart{}) == []
    end

    test "returns an empty list when the dataset does not have data" do
      dataset = %Dataset{
        x_categories: @x_categories,
        y_categories: @y_categories,
        data: []
      }

      assert BubbleMatrixChart.bubbles(%BaseChart{dataset: dataset}) == []
    end

    test "returns bubble labels" do
      bubbles = Enum.map(BubbleMatrixChart.bubbles(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert bubbles
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "returns bubble original values" do
      bubbles = Enum.map(BubbleMatrixChart.bubbles(@chart), & &1.value)
      values = Enum.map(@data, & &1.value)

      assert bubbles == values
    end

    test "returns bubble fill colors" do
      bubbles = Enum.map(BubbleMatrixChart.bubbles(@chart), & &1.fill_color)
      fill_colors = Enum.map(@data, & &1.fill_color)

      assert bubbles == fill_colors
    end

    test "returns bubble metadata" do
      bubbles = Enum.map(BubbleMatrixChart.bubbles(@chart), & &1.metadata)
      metadata = Enum.map(@data, & &1.metadata)

      assert bubbles == metadata
    end

    test "returns bubble categories" do
      [bubble | _] = BubbleMatrixChart.bubbles(@chart)

      assert bubble.x == "Procedure One"
      assert bubble.y == "Group One"
    end

    test "calculates horizontal offsets from the ordered x categories" do
      x_offsets = Enum.map(BubbleMatrixChart.bubbles(@chart), & &1.x_offset)

      assert x_offsets == [
               16.666666666666668,
               50.0,
               83.33333333333334,
               16.666666666666668
             ]
    end

    test "calculates vertical offsets from the ordered y categories" do
      y_offsets = Enum.map(BubbleMatrixChart.bubbles(@chart), & &1.y_offset)

      assert y_offsets == [
               16.666666666666668,
               50.0,
               83.33333333333334,
               83.33333333333334
             ]
    end

    test "calculates bubble radii using square-root scaling" do
      radii = Enum.map(BubbleMatrixChart.bubbles(@chart), & &1.radius)

      assert radii == [4.375, 6.25, 10.0, 0.0]
    end

    test "returns complete bubble display properties" do
      [bubble | _] = BubbleMatrixChart.bubbles(@chart)

      expected = %Bubble{
        label: "Procedure One / Group One",
        x: "Procedure One",
        y: "Group One",
        x_offset: 16.666666666666668,
        y_offset: 16.666666666666668,
        radius: 4.375,
        fill_color: :blue,
        value: 25,
        metadata: %{percentage: 10.0}
      }

      assert bubble == expected
    end
  end

  describe "x_categories/1" do
    test "returns the ordered horizontal categories" do
      assert BubbleMatrixChart.x_categories(@chart) == @x_categories
    end

    test "returns an empty list when the chart does not have a dataset" do
      assert BubbleMatrixChart.x_categories(%BaseChart{}) == []
    end
  end

  describe "y_categories/1" do
    test "returns the ordered vertical categories" do
      assert BubbleMatrixChart.y_categories(@chart) == @y_categories
    end

    test "returns an empty list when the chart does not have a dataset" do
      assert BubbleMatrixChart.y_categories(%BaseChart{}) == []
    end
  end
end
