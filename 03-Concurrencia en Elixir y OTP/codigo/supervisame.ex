defmodule Supervisame do

  use Supervisor

  def start_link(_args) do
      IO.puts "[Spervisame] Iniciando supervisor"
      Supervisor.start_link([
          {Supervisame.Calculadora, []},
          {Supervisame.Pila, []}
      ], strategy: :one_for_one)
  end

end
