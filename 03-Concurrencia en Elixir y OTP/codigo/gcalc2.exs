defmodule GCalc2 do
  use GenServer

  def add(pid, x, y) do
      Genserver.call(pid,{:add,x,y})
  end

  def init(param) do
    IO.puts "Inicio GenServer GCalc"
    IO.inspect param
    {:ok, %{conteo: 0}}
  end

  def handle_call({:add, n, m}, _from, %{conteo: conteo}) do
      IO.puts "handle call #{n} y #{n}"
      #Process.sleep(6000)
      #IO.puts "WAKEUP"
      result = n+m
      {:reply, result, %{conteo: conteo + 1}}
  end

  def handle_cast(:reset, _state) do
      IO.puts "handle cast"
      {:noreply, %{conteo: 0}}
  end

  def handle_info(:hello, %{conteo: conteo}) do
      IO.puts "conteo #{conteo}"
      {:noreply, %{conteo: conteo + 1}}
  end

  def handle_info(:world, state) do
      {:noreply, state}
  end

end
