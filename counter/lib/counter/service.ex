defmodule Counter.Service do
  alias Counter.Core

  defp loop(count) do
    count |> listen() |> loop()
  end

  defp listen(count) do
    receive do
      :inc ->
        Core.inc(count)

      {:show, from_pid} ->
        send(from_pid, Core.show(count))
        count
    end
  end

  # client side API
  def start(input) do
    spawn fn ->
      input |> Core.new() |> loop()
    end
  end

  def inc(counter_pid) do
    send(counter_pid, :inc)
    :ok
  end

  def show(counter_pid) do
    send(counter_pid, {:show, self()})
    receive do
      count -> count
    end
  end
end
