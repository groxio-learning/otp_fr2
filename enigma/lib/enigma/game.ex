defmodule Enigma.Game do
  defstruct [answer: [1, 2, 3, 4], attempts: []]

  alias Enigma.Game.Score

  @max_attempts 10

  def generate_answer() do
    1..8 |> Enum.shuffle() |> Enum.take(4)
  end

  def new(answer) do
    %__MODULE__{answer: answer}
  end

  def guess(%__MODULE__{} = game, attempt) do
    %{game | attempts: [attempt | game.attempts]}
  end

  def render_row(attempt, answer) do
    (attempt |> Enum.join(" ")) <> " | " <> Score.render(answer, attempt)
  end

  def render(game) do
    game.attempts
      |> Enum.map(&render_row(&1, game.answer))
      |> Enum.join("\n")
      |> Kernel.<>("\n#{status(game)}")

    # """
    # 1 2 3 4 | RW
    # 4 1 5 3 | RRWW
    # Playing
    # """
  end

  defp status(game) do
    cond do
      won?(game) ->
        "Won"
      lost?(game) ->
        "Lost"
      true ->
        "Playing"
    end
  end

  defp won?(%__MODULE__{answer: answer, attempts: [answer | _rest]}), do: true
  defp won?(_game), do: false

  defp lost?(%__MODULE__{attempts: attempts}) when length(attempts) >= @max_attempts, do: true
  defp lost?(_game), do: false

  def active?(game), do: won?(game) || lost?(game)
end

# use this to test playing:
# [1, 2, 3, 4] |> Game.new() |> Game.guess([4, 3, 2, 1]) |> Game.guess([1, 2, 3, 4]) |> Game.guess([5, 6, 7, 8]) |> Game.guess([1, 2, 4, 3])|> Game.render() |> IO.puts()

# use this to test lost:
# [1, 2, 3, 4] |> Game.new() |> Game.guess([4, 3, 2, 1]) |> Game.guess([1, 2, 3, 4]) |> Game.guess([5, 6, 7, 8]) |> Game.guess([1, 2, 3, 4]) |> Game.guess([5, 6, 7, 8])|> Game.guess([5, 6, 7, 8])|> Game.guess([5, 6, 7, 8])|> Game.guess([5, 6, 7, 8])|> Game.guess([5, 6, 7, 8]) |> Game.guess([5, 6, 7, 8]) |> Game.render() |> IO.puts()

# use this to test won:
# [1, 2, 3, 4] |> Game.new() |> Game.guess([4, 3, 2, 1]) |> Game.guess([1, 2, 3, 4]) |> Game.guess([5, 6, 7, 8]) |> Game.guess([1, 2, 3, 4])|> Game.render() |> IO.puts()
