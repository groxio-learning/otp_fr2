defmodule Enigma do
  def start(game_name) do
    DynamicSupervisor.start_child(:dysup, {Enigma.Server, game_name})
  end

  def guess(game_name, attempt) do
    Enigma.Server.attempt(game_name, attempt)
  end
end
