defmodule Enigma.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("Starting application")

    # children = [
    #   {Enigma.Server, :hulk},
    #   {Enigma.Server, :batman},
    #   {Enigma.Server, :spiderman},
    #   {Enigma.Server, :neo},
    #   {Enigma.Server, :thor},
    #   {Enigma.Server, :lukeskywalker},
    #   {Enigma.Server, :wonderwoman},
    #   {Enigma.Server, :wolverine},
    #   {Enigma.Server, :blackpanther}
    #   # Starts a worker by calling: Enigma.Worker.start_link(arg)
    #   # {Enigma.Worker, arg}
    # ]
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: :dysup}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Enigma.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
