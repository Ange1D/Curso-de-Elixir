defmodule Prueba do

  @spec suma(number(), number()) :: number()
  def suma(a,b) do
      a + b
  end

  @spec prueba :: number
  def prueba() do
      suma(1,2)
  end

  @spec prueba2 :: 5
  def prueba2() do
      5
  end
end
