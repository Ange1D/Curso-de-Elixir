defmodule Supervisame.MainSup do

  use Supervisor

  def start_link(args) do
      IO.puts "[MainSup] Lanzando mainsup"
      IO.inspect args
      Supervisor.start_link([
          {Supervisame, []}
      ], strategy: :one_for_one)
  end
end
