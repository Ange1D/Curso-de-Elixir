defmodule Calculadora do

  #guarda
  def dividir(_a,b) when b == 0 do
      :inf
  end

  def dividir(a,b) do
      a/b
  end
end
