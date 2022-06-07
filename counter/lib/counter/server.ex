defmodule Counter.Server do
  use GenServer

  alias Counter.Core

  # Client

  def start_link(value) do
    GenServer.start_link(__MODULE__, value, name: :dracula)
  end

  def inc(pid) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid) do
    GenServer.cast(pid, :dec)
  end

  def show(pid) do
    GenServer.call(pid, :show)
  end

  # Server (callbacks)

  @impl true
  def init(value) do
    {:ok, Core.new(value)}
  end

  @impl true
  def handle_call(:show, _from, counter) do
    {:reply, Core.show(counter), counter}
  end

  @impl true
  def handle_cast(:inc, counter) do
    {:noreply, Core.inc(counter)}
  end

  @impl true
  def handle_cast(:dec, counter) do
    {:noreply, Core.dec(counter)}
  end
end
