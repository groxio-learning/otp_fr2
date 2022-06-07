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
		0..(reds-1) |> Enum.map(fn _x -> "R" end) |> join()
		0..(whites-1) |> Enum.map(fn _x -> "W" end) |> join()
	end
end