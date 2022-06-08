defmodule Enigma.Game.Score do

  defstruct [:red, :white]

  def new(answer, attempt) do
    reds =
      Enum.zip(answer, attempt)
      |> Enum.filter(fn {a, g} -> a == g end)
      |> Enum.count

    misses = attempt -- answer
    whites = Enum.count(answer) - reds - Enum.count(misses)
    %__MODULE__{red: reds, white: whites}
  end

  def show(%__MODULE__{red: reds, white: whites}) do
    String.duplicate("R", reds) <> String.duplicate("W", whites)

    # previous implementation
    # (0..(reds-1) |> Enum.map(fn _x -> "R" end) |> Enum.join()) <>
    #   (0..(whites-1) |> Enum.map(fn _x -> "W" end) |> Enum.join())

    # implementation with streams
    # stream_of_r = Stream.cycle('R') |> Stream.take(reds)
    # stream_of_w = Stream.cycle('W') |> Stream.take(whites)

    # Stream.concat(stream_of_r, stream_of_w) |> Enum.to_list() |> to_string()
  end

  def render(answer, attempt) do
    # new() |> show()
    new(answer, attempt) |> show
  end
end
