defmodule GCalc do
  use GenServer

  def init(param) do
  IO.puts "Inicio GenServer GCalc"
  IO.inspect param
  {:ok, %{conteo: 0}}
  end

  def handle_info(msg, state) do
      IO.puts "Me mandan mensaje #{msg}"
      {:noreply, state}
  end

end
