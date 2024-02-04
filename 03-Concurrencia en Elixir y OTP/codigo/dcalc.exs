defmodule DCalc do
  def calculadora(contador) do
      receive do
          {pid, :+, a,b} -> send(pid, a+b)
          {pid, :-, a,b} -> send(pid, a-b)
          {pid, :x, a,b} -> send(pid, a*b)
          {pid, :/, a,0} -> exit("division entre cero")
          {pid, :/, a,b} -> send(pid, a/b)
          {pid, :cont} -> send(pid, contador)
      end
      calculadora(contador + 1)
  end
end
