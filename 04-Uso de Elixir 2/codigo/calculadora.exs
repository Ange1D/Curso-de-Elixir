defmodule Calculadora.ErrorCalculo do
  defexception message:"Se ha producido un error de calculo"
end

defmodule Calculadora do
  def dividir(x,y) do
      if y ==0 do
      #raise "dividiendo entre 0"
      #raise ArgumentError, message: "division entre 0"
      raise Calculadora.ErrorCalculo
      else
          x/y
      end
  end
end

IO.puts Calculadora.dividir(5,0)
