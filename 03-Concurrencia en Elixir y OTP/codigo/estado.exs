defmodule Estado do

  def contador(), do: contador(0)

  def contador(value) do
      new_value = receive do
      {:get, pid} ->
          send(pid, value)
          contador(value)
          value
      {:inc} ->
          value + 1
      {:dec} ->
          value - 1
      {:reset} ->
      0
      end
      contador(new_value)
  end

  def contadorDos() do
  value = Process.get(:valor) || 0
      receive do
          {:get, pid} ->
              send(pid, Process.get(:valor))
          {:inc} ->
              Process.put(:valor, value + 1)
          {:dec} ->
              Process.put(:valor, value - 1)
          {:reset} ->
              Process.put(:valor, 0)
      end
      contadorDos
  end

end
