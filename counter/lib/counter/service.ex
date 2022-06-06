defmodule Counter.Service do
  alias Counter.Core

  def listen(count) do
    receive do
      :inc ->
        Core.inc(count)

      {:show, from_pid} ->
        send(from_pid, Core.show(count))
        count
    end
  end
end
