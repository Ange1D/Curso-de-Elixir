defmodule Prueba.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Prueba.Hola, :ok},
      {Plug.Cowboy, [scheme: :http, plug: Prueba.EndPoint, options:[port: 4001]]}
      # Starts a worker by calling: Prueba.Worker.start_link(arg)
      # {Prueba.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Prueba.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
