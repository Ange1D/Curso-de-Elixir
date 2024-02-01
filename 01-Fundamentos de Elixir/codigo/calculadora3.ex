defmodule Calculadora do

  def dividir(_a,0) do
      :inf
  end

  def dividir(a,b) when is_number(a) and is_number(b) do
      a/b
  end

  def dividir(_a,_b) do
      :invalid
  end

  def print2({:ok,x}) do
      IO.puts("ok")
  end

  def print2({:error,_}) do
      IO.puts("error")
  end

end
