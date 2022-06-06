defmodule Counter do
  @moduledoc """
  Documentation for `Counter`.
  """
  defstruct [:count]

  def new(str) do
    %__MODULE__{count: String.to_integer(str)}
  end

  def inc(%{count: int}) do
    %__MODULE__{count: int + 1}
  end

  def dec(%{count: int} = counter) do
    %{counter | count: int - 1}
  end

  def show(%{count: val}) do
    "The counter is: #{val}"
  end
end
