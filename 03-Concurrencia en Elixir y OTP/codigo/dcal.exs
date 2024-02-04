defmodule DCalc do
  def calculadora do
      receive do
          {pid, :+, a,b} -> send(pid, a+b)
          {pid, :-, a,b} -> send(pid, a-b)
          {pid, :x, a,b} -> send(pid, a*b)
          {pid, :/, a,0} -> exit("division entre cero")
          {pid, :/, a,b} -> send(pid, a/b)
      end
      calculadora
  end
end
