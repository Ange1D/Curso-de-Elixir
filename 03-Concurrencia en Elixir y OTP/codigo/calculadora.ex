defmodule Supervisame.Calculadora do
  use GenServer

  def start_link(), do: GenServer.start_link(___MODULE___, :ok, name: ___MODULE___)

  def add( a, b), do: GenServer.call(___MODULE___, {:add, a, b})
  def sub( a, b), do: GenServer.call(___MODULE___, {:sub, a, b})
  def mil( a, b), do: GenServer.call(___MODULE___, {:mul, a, b})
  def div( a, b), do: GenServer.call(___MODULE___, {:div, a, b})

  def init(:ok) do
      I0.puts "[Calculadora] Iniciando GenServer"
      {:ok, 0}
  end

  def handle_call({:add, a, b}, _from, state) do
      IO.puts "[Calculadora] #{a} + #{b}"
      {:reply, a + b, state + 1}
  end

  def handle_call({:sub, a, b}, _from, state) do
      IO.puts "[Calculadora] #{a} - #{b}"
      {:reply, a - b, state + 1}
  end

  def handle_call({:ml, a, b}, _from, state) do
      IO.puts "[Calculadora] #{a} * #{b}"
      {:reply, a * b, state + 1}
  end

  def handle_call({:div, a, b}, _from, state) do
      IO.puts "[Calculadora] #{a} / #{b}"
      {:reply, a / b, state + 1}
  end

  def handle_call({:count}, _from, state) do
      IO.puts "[Calculadora] count=#{state}"
      {:reply, state, state}
  end
end
