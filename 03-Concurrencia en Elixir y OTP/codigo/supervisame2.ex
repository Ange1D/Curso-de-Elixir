supervisame.ex

defmodule Supervisame2 do

    use Supervisor

    def start_link(args) do
        IO.puts "[Supervisame] Iniciando supervisor"
        IO.inspect args
        Supervisor.start_link(__MODULE_, :ok, name: __MODULE__)
    end

    def init(args) do
        IO.puts "[Supervisame] Llamo a init"
        IO.inspect args
        children = [
            {Supervisame2.Calculadora, []},
            {Supervisame2.Pila, []}
        ]
        Supervisor.init(children, strategy: :one_for_one)
    end

end
