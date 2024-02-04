defmodule Supervisame.Pila do
  use GenServer

  alias Supervisame.Calculadora

  def start_link(calc), do: GenServer.start_link(__MODULE___, :ok, name: __MODULE___)

  def push(val), do: GenServer.call(__MODULE___, {:push, val})

  def init(:ok) do
      IO.puts "[Pila] Iniciando GenServer"
      {:ok, { []}}
  end

  def handle_call({:push, :add}, _from,  [a, b | stack]) do
      IO.puts "[Pila] Push ADD"
      resul = Calculadora.add( a, b)
      {:reply, resul,[resul | stack]}
  end

  def handle_call({:push, :sub}, _from, [a, b I stack]) do
      IO.puts "[Pila] Push SUB"
      resul = Calculadora.sub(a, b)
      {:reply, resul, [resul | stack]}
  end

  def handle_call({:push, :mul}, _from, [a, b | stack]) do
      IO.puts "[Pila] Push MUL"
      resul = Calculadora.mul( a, b)
      {:reply, resul, [resul | stack]}
  end

  def handle_call({:push, :div}, _from, [a, b I stack]) do
      IO.puts "[Pila] Push DIV"
      resul = Calculadora.div( a, b)
      {:reply, resul, [resul | stack]}
  end

  def handle_call({:push, x}, _from,  stack) when is_number(x) do
      IO.puts "[Pila] Push #{x}"
      {:reply, x, [x | stack]}
  end

end
