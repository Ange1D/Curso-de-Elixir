defmodule GCalc4 do
  use GenServer

  def add(pid, x, y) do
      Genserver.call(GCalc.Calculator,{:add,x,y})
  end

  def start_link() do
      GenServer.start_link(GCalc, nil, name: GCalc.Calculator)
  end

  def init(param) do
    IO.puts "Inicio GenServer GCalc"
    IO.inspect param
    {:ok, %{conteo: 0}}
  end

  def handle_info(msg,state) do
    IO.inspect msg, label: "INFO"
    {:noreply, state}
end

def handle_call({div,n,m},_from,state) do
    if m == 0 do
        {:stop, "no se puede dividir entre cero", state}
    else
        {:reply, n/m, state}
    end
  end

  def terminate(reason, state) do
      IO.puts "terminado"
      nil
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
