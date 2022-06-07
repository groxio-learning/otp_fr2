defmodule EnigmaTest do
  use ExUnit.Case
  doctest Enigma

  test "greets the world" do
    assert Enigma.hello() == :world
  end
end
