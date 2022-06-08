defmodule Enigma.Server do
  use GenServer

  alias Enigma.Game

  def init(answer) do
    {:ok, Game.new(answer)}
  end

  def handle_call({:attempt, attempt}, _from, %Game{} = game) do
    new_game = Game.guess(game, attempt)
    {:reply, Game.render(new_game), new_game}
  end

  def child_spec(game_name) do
    %{id: game_name, start: {Enigma.Server, :start_link, [game_name]}}
  end

  # API
  def start_link(game_name) do
    IO.puts("Starting game: #{game_name}")
    GenServer.start_link(__MODULE__, Game.generate_answer(), name: game_name)
  end

  def attempt(game_name, attempt) do
    IO.puts("Attempt made")
    GenServer.call(game_name, {:attempt, attempt})
    |> IO.puts()
  end
end
