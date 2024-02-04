defmodule GCalc3 do
  use GenServer

    def add(pid, x, y) do
        Genserver.call(pid,{:add,x,y})
    end

    def init(param) do
        IO.puts "Inicio GenServer GCalc"
        IO.inspect param
        #Process.sleep(6000)
        #{:ok, %{conteo: 0}}
        #{:ok, %{conteo: 0, 3000}}
        #{:stop."base de datos no esta online"}
        :ignore
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
